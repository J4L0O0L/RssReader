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

protocol BookmarksControllerViewModelType: class {
    var cellSelectedSubject: PublishSubject<BookmarkCellViewModelProtocol> { get }
    var cellViewModelsDriver: Driver<[BookmarkCellViewModel]> { get }
} 

final class BookmarksControllerViewModel: BaseViewModel, BookmarksControllerViewModelType {
    
    // MARK: - Init and deinit
    override init() {
        super.init()
        cellSelectedSubject
            .bind(onNext: cellSelected)
            .disposed(by: bag)

    }
    
    deinit {
        print("\(self) dealloc")
    }
    
    
    // MARK: - Properties
    private let dataSubject = BehaviorSubject<[BookmarkCellViewModel]>(value: [])
    
    var cellSelectedSubject = PublishSubject<BookmarkCellViewModelProtocol>()
    
    var cellViewModelsDriver: Driver<[BookmarkCellViewModel]> {
        //isLoading = true
        return BookmarkDAL.shared.fetchAll().map({ $0.map( BookmarkCellViewModel.init)}).asDriver(onErrorJustReturn: [])
    }
    
    // MARK: - Functions
    
    func cellSelected(_ viewModel: BookmarkCellViewModelProtocol){
        
    }
    
    
    
}
