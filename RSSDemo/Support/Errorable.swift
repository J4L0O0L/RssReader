//
//  Errorable.swift
//  RSSDemo
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import RxSwift

enum Exception {
    case failure(message: String)
}

protocol Errorable {
    var onError: PublishSubject<Exception> {get set}
}

extension Errorable {
    
    func catchError(error: Error) {
        let e = error as! CustomError
        switch e {
        default: self.onError.onNext(.failure(message: (error as! CustomError).localization))
        }
        
    }
}

