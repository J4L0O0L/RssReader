//
//  RssCellViewModel.swift
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation

struct RssCellViewModel: RssViewModelProtocol {
    func getModel() -> Any? {
         return ""
    }
    
    func getReuseIdentifier() -> String {
         return ""
    }
    
    func nibName() -> String {
        return ""
    }
    
    
    init(){
        self.channel = FeedItem(title: "", link: "", description: "", pubDate: "", category: [])
    }

    init(_ channel: FeedItem) {
        self.channel = channel
    }
    
    private let channel: FeedItem
    
    var isBookmarked: Bool {
        get{ return BookmarkDAL.shared.fetchBy(title: channel.title) != nil}
    }
    
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
