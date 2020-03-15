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

final class BookmarksViewModel: BaseViewModel, BookmarkViewModelProtocol {
 
    
   
    // MARK: - Init and deinit
    override init() {
        super.init()
    }
    
    deinit {
        print("\(self) dealloc")
    }
    
    func attachView(view: BaseViewProtocol) {
        self.view = view as? BookmarkViewProtocol
        loadBookmarks()
    }
    
    // MARK: - Properties
    weak private var view: BookmarkViewProtocol?

    
    // MARK: - Functions
    func loadBookmarks(){
        
        BookmarkDAL.shared.fetchAll()
            .map({ $0.map( BookmarkCellViewModel.init)})
            .subscribe(onNext: view?.loadBookmarks)
            .disposed(by: bag)
    }
    
    
}
