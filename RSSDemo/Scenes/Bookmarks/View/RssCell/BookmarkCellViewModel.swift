//
//  RssCellViewModel.swift
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation

protocol BookmarkCellViewModelProtocol  {
    var title: String  { get }
    var link: String  { get }
    var description: String  { get }
}

struct BookmarkCellViewModel: BookmarkCellViewModelProtocol {

    init(_ channel: Bookmark) {
        self.channel = channel
    }
    
    private let channel: Bookmark
    
    var link: String{
        return channel.link ?? ""
    }
    
    var description: String{
        return channel.des ?? ""
    }
    
    var title: String {
        return channel.title ?? ""
  }

}
