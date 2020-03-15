//
//  SingleXmlResource.swift
//  RSSDemo
//
//  Created by MohammadReza Jalilvand on 19.05.2018.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import RxSwift
import SWXMLHash

struct ResponseResource<T : RequestModelProtocol> {
    let action: APIAction
    let parser: ParserProtocol
    
    func parse(_ data: Data) -> Observable<T> {
        return parser.parse(data)
    }
}

