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

final class RssViewModel: BaseViewModel, RssTableViewModelProtocol {
   
    
   
    // MARK: - Init and deinit
    init( networkservice: NetworkServiceProtocol, selectedMode: FetchTarget) {
        self.selectedMode = BehaviorSubject<FetchTarget>(value: selectedMode)
        self.repository = RssRepository(networkservice)
        super.init()
    }
    
    deinit {
        print("\(self) dealloc")
    }
    
    
    // MARK: - Properties
    weak private var view: RssViewProtocol?
    private var repository: RssRepositoryProtocol?
    private var data = [RssCellViewModel]()
    
    var selectedMode: BehaviorSubject<FetchTarget>

    func attachView(view: BaseViewProtocol) {
        self.view = view as? RssViewProtocol
        setBinding()
    }
    
    func setBinding(){
        selectedMode
            .do(onNext: {_ in self.isLoading = true})
            .bind(to: repository!.getFeed)
            .map({ rssList in
                return rssList.map { rssModel in
                    var model = RssCellViewModel(delegate: self, model: rssModel)
                    model.isBookmarked = BookmarkDAL.shared.fetchBy(title: model.title) != nil
                    return model
                }
            })
            .do(onNext: { data in
                self.isLoading = false
                self.data = data as! [RssCellViewModel]
            })
            .bind(onNext: view!.setTable).disposed(by: bag)
    }
    
    // MARK: - Functions
    func realmCompletion(_ model: RssModelProtocol){
        if let itemIndex = data.map({ item in
            return item.title
        }).firstIndex(of: model.title){
            let isBookmark = data[itemIndex].isBookmarked
            self.data[itemIndex].isBookmarked = !isBookmark
        
            view?.reloadTable(self.data)
            Notifire.shared().showMessage(message: Message.bookmarkSavedSuccessfully.rawValue, type: .success)
        }
        
    }
    
}

extension RssViewModel : CellSelectDelegate {
    func cellSelected(model: Any) {
        if let data = model as? RssViewModelProtocol {
            repository?.setBookmark(data: data, completion: realmCompletion)
        }
    }
}
