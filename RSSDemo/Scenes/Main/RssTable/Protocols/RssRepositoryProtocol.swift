//
//  MainRepositoryProtocol.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 23/02/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation
import RxSwift

protocol RssRepositoryProtocol {
    func getFeed(_ target: Observable<FetchTarget>) -> Observable<[RssModelProtocol]>
    func setBookmark(data: RssViewModelProtocol, completion: dalCompletionWith?)
}
