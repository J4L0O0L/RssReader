//
//  FeedChannel.swift
//  RSSDemo
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation

struct FeedChannelJson: RequestModelProtocol {
    let title: String
    let copyright: String
    let country: String
    let icon: String
    let updated: String
    let results: [FeedItemJson]
    
}
