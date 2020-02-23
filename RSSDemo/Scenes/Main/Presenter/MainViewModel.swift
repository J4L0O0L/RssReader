//
//  MainVM.swift
//  RSSDemo
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MainViewModel: BaseViewModel, MainViewModelProtocol {
   
    // MARK: - Init and deinit
    init( networkservice: NetworkService) {
        super.init()
        repository = MainRepository(networkservice)
        
    }
    
    deinit {
        print("\(self) dealloc")
    }
    
    
    // MARK: - Properties
    weak private var view: MainViewProtocol?
    private var repository: MainRepositoryProtocol?
    private var service : NetworkService?
    private let dataSubject = BehaviorSubject<[RssCellViewModel]>(value: [])
    
    var modeSelectedSubject = PublishSubject<FetchTarget>()
    var bookmarkSelectedSubject = PublishSubject<(IndexPath, RssViewModelProtocol)>()
    var cellSelectedSubject = PublishSubject<RssViewModelProtocol>()
    var cellUpdatedDriver =  PublishSubject<(IndexPath, RssViewModelProtocol)>()
    
    var cellViewModelsDriver: Driver<[RssCellViewModel]> {
        return dataSubject.do(onNext: { viewModel in
            self.isLoading = false
        }).asDriver(onErrorJustReturn: [])
    }
    
    func attachView(_ vc: MainViewProtocol){
        self.view = vc
        setBinding()
        
        modeSelectedSubject.onNext(.unitedKingdom)
    }
    
    func setBinding(){
        modeSelectedSubject
            .bind(to: repository!.getFeed)
            .map({$0.map({FeedCellViewModel(parent: self, model: $0)})})
            .bind(onNext: view!.setTable)
            .disposed(by: bag)
    }
    
    // MARK: - Functions
    func targetSelected(_ target: FetchTarget) {
        isLoading = true
        switch target {
        case .unitedSates:
            service?
                .loadXml(SingleXmlResource<Feed>(action: RssAction.unitedStates))
                .map { $0.rss.channel.items.map(RssCellViewModel.init) }
                .subscribe(dataSubject)
                .disposed(by: bag)
            
        case .unitedKingdom:
            service?
                .loadXml(SingleXmlResource<Feed>(action: RssAction.unitedKingdom))
                .map { $0.rss.channel.items.map(RssCellViewModel.init) }
                .subscribe(dataSubject)
                .disposed(by: bag)
        }
    }
    
    func bookmarkRssCell(model: RssViewModelProtocol) {
        let index = findIndex(for: model)
        model.isBookmarked ? BookmarkDAL.shared.removeBy(title: model.title,complete: realmCompletion) :  BookmarkDAL.shared.insertBookmark(model: model,completion: realmCompletion)
    }
    
    private func findIndex(for model: RssViewModelProtocol) -> IndexPath {
        return IndexPath(row: 0, section: 0)
    }
    
    
    func setBookmarked(index: IndexPath, viewModel: RssViewModelProtocol){
        let feed = FeedItem(title: viewModel.title, link: viewModel.link, description: "", pubDate: "", category: [])
        BookmarkDAL.shared.insertBookmark(model: feed,completion: realmCompletion)
    }
    
    
    func deleteBookmarked(index: IndexPath, viewModel: RssViewModelProtocol){
        BookmarkDAL.shared.removeBy(title: viewModel.title,complete: realmCompletion)
    }
    
    func realmCompletion(){
       
        //view?.setTable(<#T##data: [CellBehavior]##[CellBehavior]#>)
        
        Notifire.shared().showMessage(message: Message.bookmarkSavedSuccessfully.rawValue, type: .success)
    }
    
    
}
