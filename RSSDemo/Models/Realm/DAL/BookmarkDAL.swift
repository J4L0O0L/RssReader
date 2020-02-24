//
//  FavoriteDAL.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 22/01/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//


import RealmSwift
import RxSwift
import RxCocoa

typealias dalCompletion = () -> Void
typealias dalCompletionWith = (_ model: RssModelProtocol) -> Void

class BookmarkDAL
{
    private var realm:Realm!
    
    static let shared = BookmarkDAL()
    
    init()
    {
        let config = Realm.Configuration(schemaVersion: 3)
        self.realm = try? Realm(configuration: config)
    }


    func removeAll(complete : dalCompletion? ) {
        try! realm.safeWrite {
            guard realm.objects(Bookmark.self).first != nil else {
                complete?()
                return
            }
            realm.deleteAll()
            complete?()
        }
    }
    
    func removeBy(title: String, complete : dalCompletion? ) {
        try! realm.safeWrite {
            guard let item = fetchBy(title: title) else {
                complete?()
                return
            }
            realm.delete(item)
            complete?()
        }
    }
    
    
    func fetchBy(title: String) -> Bookmark? {
        return realm.objects(Bookmark.self).filter(NSPredicate(format: "title == %@",title)).first
    }
    
    func fetch(id: String) -> Bookmark?
    {
        guard let Bookmark = realm.object(ofType: Bookmark.self, forPrimaryKey: id) else {
            return nil
            
        }
        return Bookmark
    }
    
    func fetchAll() -> Observable<[Bookmark]> {
        return Observable.just(realm.objects(Bookmark.self).toArray())
        
        
    }
    
    func insertBookmark(model: RssModelProtocol, completion: dalCompletion?) {
       
        try! realm.safeWrite {
            let bookmark = Bookmark()
               
            bookmark.title = model.title
            bookmark.link = model.link
            bookmark.des = model.description
            
            realm.add(bookmark)
            completion?()
        }
    }


}

