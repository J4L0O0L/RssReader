//
//  MainViewModelProtocol.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 23/02/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol MainViewModelProtocol: class {
    func attachView(_ view: MainViewProtocol)
    func bookmarkRssCell(model: RssViewModelProtocol)
    var modeSelectedSubject: PublishSubject<FetchTarget> { get }
    var cellSelectedSubject: PublishSubject<RssViewModelProtocol> { get }
    var cellViewModelsDriver: Driver<[RssCellViewModel]> { get }
    var bookmarkSelectedSubject: PublishSubject<(IndexPath,RssViewModelProtocol)> { get }
    var cellUpdatedDriver: PublishSubject<(IndexPath, RssViewModelProtocol)> { get }
}
