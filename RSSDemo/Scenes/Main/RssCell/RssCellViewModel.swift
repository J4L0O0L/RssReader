//
//  RssCellViewModel.swift
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation

protocol RssCellViewModelType {
    var title: String  { get }
    var link: String  { get }
    var description: String  { get }
}

struct RssCellViewModel: RssCellViewModelType {
   
    init(_ channel: FeedItem) {
        self.channel = channel
    }
    
    private let channel: FeedItem
    
    
    var link: String{
        return channel.link
    }
    
    var description: String{
        return channel.description
    }
    
    var title: String {
        return channel.title
  }

}
