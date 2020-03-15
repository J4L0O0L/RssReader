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
    init(data: RssViewModelProtocol, delegate: DetailViewDelegate){
        super.init()
        self.data = data
        self.delegate = delegate
    }
   
    deinit {
        print("\(self) dealloc")
    }
     
    // MARK: - Properties
    weak private var view: DetailViewProtocol?
    var data: RssViewModelProtocol?
    let disposeBag = DisposeBag()
    
    var delegate: DetailViewDelegate?
    
    var bookmarkedSelection = PublishSubject<Void>()
    
    
    func attachView(view: BaseViewProtocol){
        self.view = view as? DetailViewProtocol
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
    
    private func realmCompletion(_ model: RssModelProtocol){
    
        let isBookmarked = data!.isBookmarked
        data?.isBookmarked = !isBookmarked
        view?.setRssDetail(data: data!)
        delegate?.rssBookmarked(model: data!)
    }
    
}
