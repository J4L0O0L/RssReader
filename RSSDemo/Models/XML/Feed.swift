//
//  Feed.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 22/01/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation
import SWXMLHash

struct Feed: RequestModelProtocol {    
    let rss: FeedRss
    
    static func deserialize(_ node: XMLIndexer) throws -> Feed {
        return try Feed(
            rss: node["rss"].value()
        )
    }

}
