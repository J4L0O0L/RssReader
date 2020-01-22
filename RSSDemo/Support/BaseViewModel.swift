//
//  BaseViewModel.swift
//  RSSDemo
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import RxSwift

class BaseViewModel: Errorable {
    
    private enum StateBase {
        case startLoading
        case stopLoading
    }
    
    var onError = PublishSubject<Exception> ()
    var bag = DisposeBag()
    
    var isLoading: Bool = false {
        didSet {
            isLoading ? onChangeBase.onNext(.startLoading) : onChangeBase.onNext(.stopLoading)
        }
    }
    
    private var onChangeBase = PublishSubject<StateBase>()
    
    init() {
        onChangeBase.subscribe(onNext: { (stateBase) in
            switch stateBase {
            case .stopLoading: Utility.stopIndicatorAnimation()
            case .startLoading: Utility.startIndicatorAnimation()
            }
        }).disposed(by: bag)
        
        onError.subscribe(onNext: { (exception) in
            switch exception {
            case .failure(let message):
                DispatchQueue.main.async {
                    Notifire.shared().showMessage(message: message, type: .error)
                }
            }
        }).disposed(by: bag)
    }
}
