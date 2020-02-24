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
    //private let dataSubject = BehaviorSubject<[RssCellViewModel]>(value: [])
    
    var modeSelectedSubject = PublishSubject<FetchTarget>()
    var bookmarkSelectedSubject = PublishSubject<(IndexPath, RssViewModelProtocol)>()
    var cellSelectedSubject = PublishSubject<RssViewModelProtocol>()
    var cellUpdatedDriver =  PublishSubject<(IndexPath, RssViewModelProtocol)>()
    
    var tableData = PublishSubject<[RssCellViewModelProtocol]>()
//    var cellViewModelsDriver: Driver<[RssCellViewModel]> {
//        return dataSubject.do(onNext: { viewModel in
//            self.isLoading = false
//        }).asDriver(onErrorJustReturn: [])
//    }
    
    func attachView(_ vc: MainViewProtocol){
        self.view = vc
        setBinding()
        
        modeSelectedSubject.onNext(.unitedKingdom)
    }
    
    func setBinding(){
        modeSelectedSubject
            .do(onNext: {_ in self.isLoading = true})
            .bind(to: repository!.getFeed)
            .map({$0.map({RssCellViewModel(delegate: self, model: $0)})})
            .do(onNext: {_ in self.isLoading = false})
            .bind(onNext: view!.setTable).disposed(by: bag)
        
    }
    
    // MARK: - Functions
   
    private func findIndex(for model: RssViewModelProtocol) -> IndexPath {
        return IndexPath(row: 0, section: 0)
    }

    func realmCompletion(){
       
        view?.reloadTable()
        Notifire.shared().showMessage(message: Message.bookmarkSavedSuccessfully.rawValue, type: .success)
    }
    
}

extension MainViewModel : RssCellDelegate {
    func bookmarkTapped(model: RssCellViewModelProtocol) {
        repository?.setBookmark(data: model, completion: realmCompletion)
    }
}
