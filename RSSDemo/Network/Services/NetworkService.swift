//
//  BasicNetworkService.swift
//  RSSDemo
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.


import RxSwift
import RxAlamofire

struct NetworkService: NetworkServiceProtocol {

    func loadFeed<T>(_ resource: ResponseResource<T>) -> Observable<T>  where T :RequestModelProtocol  {
        return
            RxAlamofire
                .request(resource.action)
                .do(onNext: {dataReq in dataReq.verboseLog()})
                .responseData()
                .map { $0.1 }
                .flatMap(resource.parse)
    }
}
