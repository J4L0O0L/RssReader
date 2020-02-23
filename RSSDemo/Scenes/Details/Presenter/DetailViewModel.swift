//
//  DetailControllerViewModel.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 22/01/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa



final class DetailViewModel: BaseViewModel, DetailViewModelProtocol {
 
    // MARK: - Init and deinit
    init(data: RssViewModelProtocol){
        super.init()
        self.data = data
    }
   
    deinit {
        print("\(self) dealloc")
    }
     
    // MARK: - Properties
    weak private var view: DetailViewProtocol?
    var data: RssViewModelProtocol?
    let disposeBag = DisposeBag()
    
    var bookmarkedSelection = PublishSubject<Void>()
    
    func attachView(_ view: DetailViewProtocol){
        self.view = view
        setupData()
    }
    
    private func setupData(){
        bookmarkedSelection.subscribe(bookmarkAction)
            .disposed(by: disposeBag)
        
        if let model = data {
            view?.setRssDetail(data: model)
            view?.loadUrl(url: model.link)
        }
    }
    
    private func bookmarkAction(_ event: Event<()>) {
        
        if let model = data {
            model.isBookmarked ? BookmarkDAL.shared.removeBy(title: model.title ,complete: self.realmCompletion) :  BookmarkDAL.shared.insertBookmark(model: model,completion: self.realmCompletion)
        }
    }
    
    private func realmCompletion(){
    
        view?.setRssDetail(data: data!)
        Notifire.shared().showMessage(message: Message.bookmarkSavedSuccessfully.rawValue, type: .success)
    }
    
}
