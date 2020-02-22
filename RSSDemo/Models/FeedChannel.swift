//
//  FeedChannel.swift
//  RSSDemo
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation
import SWXMLHash

struct FeedChannel: XMLIndexerDeserializable {
    let title: String
    let link: String
    let description: String
    let lastBuildDate: String
    let category: String
    let items: [FeedItem]
    
    static func deserialize(_ node: XMLIndexer) throws -> FeedChannel {
        return try FeedChannel(
            title: node["title"].value(),
            link: node["link"].value(),
            description: node["description"].value(),
            lastBuildDate: node["lastBuildDate"].value(),
            category: node["category"].value(),
            items: node["item"].all.compactMap { elem in
                try elem.value()
            }
        )
    }
}
