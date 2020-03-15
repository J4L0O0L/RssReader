//
//  AlbumCellViewModel.swift
//  networkTest
//
//  Created by Alexey Savchenko on 24.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

protocol FeedChannelViewModelType {
    var title: String  { get }
    var link: String  { get }
    var description: String  { get }
    var items: [FeedItem] { get }
}

struct FeedChannelViewModel: FeedChannelViewModelType {
    
    init(_ channel: FeedChannel) {
        self.channel = channel
    }
    
    private let channel: FeedChannel
    
    var link: String{
        return channel.link
    }
    
    var description: String{
        return channel.description
    }
    
    var title: String {
        return channel.title
  }
    
    var items: [FeedItem] {
        return channel.items
    }
}
