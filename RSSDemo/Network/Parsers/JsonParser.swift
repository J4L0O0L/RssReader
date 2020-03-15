//
//  JsonParser.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 26/02/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation
import RxSwift

struct JsonParser: ParserProtocol {
    
    func parse<T>(_ data: Data) -> Observable<T> where T : RequestModelProtocol {
        return Observable.create { observer in
            let decoder = JSONDecoder()
            var mapedResult : T?
            do {
                mapedResult = try decoder.decode(T.self, from: data) 
            } catch {
                
            }
            
            if let res = mapedResult {
                observer.onNext(res)
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
   // let objectType = T.self

}
