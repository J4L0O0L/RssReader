//
//  NetworkService.swift
//  RSSDemo
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import RxSwift

protocol NetworkService {
    func loadXml<T>(_ resource: SingleXmlResource<T>) -> Observable<T>
}
