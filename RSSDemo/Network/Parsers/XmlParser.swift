//
//  JsonParser.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 26/02/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation
import RxSwift
import SWXMLHash

struct XmlParser : ParserProtocol {
    func parse<T>(_ data: Data) -> Observable<T> where T : RequestModelProtocol {
        return Observable.create { observer in
            
            let result = SWXMLHash.parse(data)
            var mapedResult : T?
            do {
                mapedResult = try result.value()
            } catch {
                //observer.onError(CustomError.failure(message: Message.invalidParse.rawValue))
            }
            
            
            if let res = mapedResult {
                observer.onNext(res)
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
}
