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

    init(_ service: NetworkService){
        self.service = service
    }
    
    private var service : NetworkService?
    
    public func getFeed(_ target: Observable<FetchTarget>) -> Observable<[FeedItem]> {
        return target.flatMap { fetchTarget -> Observable<[FeedItem]> in
            switch fetchTarget {
            case .unitedSates:
                return self.service?
                    .loadXml(SingleXmlResource<Feed>(action: RssAction.unitedStates))
                    .map { $0.rss.channel.items } ?? Observable.just([])
                
                
            case .unitedKingdom:
                return self.service?
                    .loadXml(SingleXmlResource<Feed>(action: RssAction.unitedKingdom))
                    .map { $0.rss.channel.items }
                    ?? Observable.just([])
            }
        }
        
    }
    
    public func setBookmark(data: RssViewModelProtocol, completion: dalCompletion?){
        
        data.isBookmarked ? BookmarkDAL.shared.removeBy(title: data.title ,complete: completion) :  BookmarkDAL.shared.insertBookmark(model: data,completion: completion)
        
    }
}
