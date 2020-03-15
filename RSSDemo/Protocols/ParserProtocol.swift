//
//  ParserProtocol.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 26/02/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation
import RxSwift

protocol ParserProtocol{
    
    func parse<T: RequestModelProtocol>(_ data: Data) -> Observable<T>
}
