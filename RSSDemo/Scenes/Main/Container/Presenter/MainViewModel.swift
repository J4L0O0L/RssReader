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
    init( networkservice: NetworkServiceProtocol) {
        networkSrv = networkservice
        super.init()
    }
    
    deinit {
        print("\(self) dealloc")
    }
    
    
    // MARK: - Properties
    weak private var view: MainViewProtocol?
    private var VCs = [Int:RssController]()
    private var networkSrv : NetworkServiceProtocol
    
    
    var modeSelectedSubject = PublishSubject<FetchTarget>()
    
    
    func attachView(view: BaseViewProtocol) {
        self.view = view as? MainViewProtocol
        setBinding()
      
        modeSelectedSubject.onNext(.unitedKingdom)
    }
    
    func setBinding(){
        modeSelectedSubject
            .map({ target in
                if let vc = self.VCs[target.hashValue] {
                    return vc
                }
                let vc =  RssController(RssViewModel(networkservice: self.networkSrv, selectedMode: target))
                self.VCs[target.hashValue] = vc
                return vc
            }).subscribe(onNext: { vc in
                self.view?.changeVC(vc)
            }).disposed(by: bag)
    }
    
    
}
