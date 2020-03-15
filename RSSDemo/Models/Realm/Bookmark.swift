//
//  Favorite.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 22/01/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import RealmSwift

class Bookmark: Object {
    //@objc dynamic  var id: NSNumber? = NSNumber(value: 0)
    @objc dynamic  var title: String?
    @objc dynamic  var link: String?
    @objc dynamic  var des: String?
    @objc dynamic  var pubDate: String?
    //dynamic  var category: List<String>?
   
//    override static func primaryKey() -> String? {
//        return "id"
//    }
    
    convenience init(title:String? = nil,
                     link:String? = nil,
                     des: String? = nil,
                     pubDate: String? = nil,
                     category: [String]? = nil)
    {
        self.init()
        //self.id = feedId
        self.title = title
        self.link = link
        self.des = des
        self.pubDate = pubDate
        
//        if let catrgories = category {
//            self.category = List<String>()
//            self.category?.append(objectsIn: catrgories)
//        }
        
    }
    
    
}

extension Bookmark {
    func makeRssModel() -> RssModelProtocol {
        return FeedItem(title: title ?? "", link: link ?? "", description: des ?? "", pubDate: pubDate ?? "", category: [])
    }
}

