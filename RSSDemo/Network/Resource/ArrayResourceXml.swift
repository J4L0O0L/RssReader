//
//  ArrayResource.swift
//  networkTest
//
//  Created by Alexey Savchenko on 19.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import RxSwift
import SWXMLHash

struct ArrayResourceXml<T: XMLIndexerDeserializable> {
  let objectType = T.self
  let action: APIAction

  func parse(_ data: Data) ->  Observable<[T]> {
     let result = SWXMLHash.parse(data)
    var mapedResult : [T]?
    do {
         mapedResult = try result["rss"]["channel"].value()
    } catch {
        
    }
    
    return Observable.create { observer in
        if let res = mapedResult {
            observer.onNext(res)
        }
        
        return Disposables.create()
    }
  }
}

