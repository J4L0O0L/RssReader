//
//  DetailView.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 23/02/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation
import RxSwift

protocol DetailViewProtocol: class {
    func loadUrl(url: String)
    func setRssDetail(data: RssViewModelProtocol)
}
