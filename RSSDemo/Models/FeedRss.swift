//
//  FeedRss.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 22/01/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation
import SWXMLHash

struct FeedRss: XMLIndexerDeserializable {
    let channel: FeedChannel
    
    static func deserialize(_ node: XMLIndexer) throws -> FeedRss {
        return try FeedRss(
            channel: node["channel"].value()
        )
    }
}
