//
//  FeedItem.swift
//  RSSDemo
//
//  Created by M4RJ4N on 1/21/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation
import SWXMLHash

struct FeedItem: XMLIndexerDeserializable {
    let title: String
    let link: String
    let description: String
    let pubDate: String
    let category: [String]
    
    static func deserialize(_ node: XMLIndexer) throws -> FeedItem {
        return try FeedItem(
            title: node["title"].value(),
            link: node["link"].value(),
            description: node["description"].value(),
            pubDate: node["pubDate"].value(),
            category: node["category"].all.compactMap { elem in
                try elem.value()
            }
            
        )
    }
}
