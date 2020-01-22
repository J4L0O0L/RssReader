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

protocol DetailControllerViewModelType: class {
    var webLoadedSubject: PublishSubject<Bool> { get }
    var linkDriver: Driver<String> { get }
}

final class DetailControllerViewModel: BaseViewModel, DetailControllerViewModelType {
    
    
    
    // MARK: - Init and deinit
    init(_ rssLink: String){
        super.init()
        isLoading = true
        
        linkSubject.onNext(rssLink)
        
        webLoadedSubject
            .bind(onNext: { _ in
                self.isLoading = false
            }).disposed(by: bag)
    }
   
    deinit {
        print("\(self) dealloc")
    }
     
    // MARK: - Properties
    private let linkSubject = BehaviorSubject<String>(value: "")
    
    var webLoadedSubject = PublishSubject<Bool>()
    var linkDriver: Driver<String>{
        return linkSubject.asDriver(onErrorJustReturn: "")
    }
   

    
    
}
