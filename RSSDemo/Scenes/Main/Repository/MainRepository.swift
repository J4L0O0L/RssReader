//
//  MainRepository.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 23/02/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation
import RxSwift

class MainRepository: MainRepositoryProtocol {

    init(_ service: NetworkServiceProtocol){
        self.service = service
    }
    
    private var service : NetworkServiceProtocol?
    
    public func getFeed(_ target: Observable<FetchTarget>) -> Observable<[RssModelProtocol]> {
        return target.flatMap { fetchTarget -> Observable<[RssModelProtocol]> in
            switch fetchTarget {
            case .unitedSates:
                return self.service?
                    .loadFeed(ResponseResource<FeedJson>(action: RssAction.unitedStates, parser: JsonParser()))
                    .map { $0.feed.results } ?? Observable.just([])
            case .unitedKingdom:
               return self.service?
                    .loadFeed(ResponseResource<Feed>(action: RssAction.unitedKingdom, parser: XmlParser()))
                    .map { $0.rss.channel.items }  ?? Observable.just([])
            }
        }
    }
    
    public func setBookmark(data: RssViewModelProtocol, completion: dalCompletion?){
        
        data.isBookmarked ? BookmarkDAL.shared.removeBy(title: data.title ,complete: completion) :  BookmarkDAL.shared.insertBookmark(model: data,completion: completion)
        
    }
}
