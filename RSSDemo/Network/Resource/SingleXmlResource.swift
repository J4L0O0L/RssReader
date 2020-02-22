//
//  SingleXmlResource.swift
//  RSSDemo
//
//  Created by MohammadReza Jalilvand on 19.05.2018.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import RxSwift
import SWXMLHash

struct SingleXmlResource<T: XMLIndexerDeserializable> {
    let objectType = T.self
    let action: APIAction
    
    func parse(_ data: Data) ->  Observable<T> {
        let result = SWXMLHash.parse(data)
        var mapedResult : T?
        do {
            mapedResult = try result.value()
        } catch {
            //throw RSSError.failure(message: Message.invalidParse.rawValue)
        }
        
        return Observable.create { observer in
            if let res = mapedResult {
                observer.onNext(res)
            }
            
            return Disposables.create()
        }
    }
}

