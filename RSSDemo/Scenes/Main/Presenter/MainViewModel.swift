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
    
    
    var modeSelectedSubject = PublishSubject<FetchTarget>()
    
    
    func attachView(view: BaseViewProtocol) {
        self.view = view as? MainViewProtocol
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
    func realmCompletion(){
        
        view?.reloadTable()
        Notifire.shared().showMessage(message: Message.bookmarkSavedSuccessfully.rawValue, type: .success)
    }
    
}

extension MainViewModel : CellSelectDelegate {
    func cellSelected(model: Any) {
        if let data = model as? RssViewModelProtocol {
            repository?.setBookmark(data: data, completion: realmCompletion)
        }
    }
}
