//
//  FeedItem.swift
//  RSSDemo
//
//  Created by M4RJ4N on 1/21/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation

struct FeedItemJson: RequestModelProtocol {
   
    
    let name: String
    let url: String
    let artistName: String
    let kind: String
    
}

extension FeedItemJson: RssModelProtocol{
    var title: String{
        return name
    }
    
    var link: String{
        return url
    }
    
    var description: String{
        return artistName
    }
}
