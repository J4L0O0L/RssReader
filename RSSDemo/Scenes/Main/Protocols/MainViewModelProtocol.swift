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

protocol MainViewModelProtocol: BaseViewModelProtocol {
    var modeSelectedSubject: PublishSubject<FetchTarget> { get }
}
