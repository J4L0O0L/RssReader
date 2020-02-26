//
//  BasicNetworkService.swift
//  RSSDemo
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.


import RxSwift
import RxAlamofire
import SWXMLHash

struct BasicNetworkService: NetworkService {
    
    func loadXml<T>(_ resource: SingleXmlResource<T>) -> Observable<T> where T : XMLIndexerDeserializable {
        return
            RxAlamofire
                .request(resource.action)
                .do(onNext: {dataReq in dataReq.verboseLog()})
                .responseData()
                .map { $0.1 }
                .flatMap(resource.parse)
    }
}
