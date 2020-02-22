//
//  DetailControllerViewModel.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 22/01/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailControllerViewModelType: class {
    var webLoadedSubject: PublishSubject<Bool> { get }
    var modelDriver: Driver<RssCellViewModelType> {get}
    var linkDriver: Driver<String> {get}
    var bookmarkedSelection: PublishSubject<Void> {get}
}

final class DetailControllerViewModel: BaseViewModel, DetailControllerViewModelType {
  
    
 
    // MARK: - Init and deinit
    init(_ rss: RssCellViewModelType){
        super.init()
        //isLoading = true
        
        modelSubject.onNext(rss)
        //linkSubject.onNext(rssLink)
        linkSubject.onNext(rss.link)
        bookmarkedSelection.bind(onNext: bookmarkedClicked).disposed(by: bag)
        
        webLoadedSubject
            .bind(onNext: { _ in
                self.isLoading = false
            }).disposed(by: bag)
    }
   
    deinit {
        print("\(self) dealloc")
    }
     
    // MARK: - Properties
    var bookmarkedSelection = PublishSubject<Void>()
    var linkDriver: Driver<String>{
        return linkSubject.asDriver(onErrorJustReturn: "")
    }
    private let linkSubject = BehaviorSubject<String>(value: "")
    private let modelSubject = BehaviorSubject<RssCellViewModelType>(value: RssCellViewModel())
    var modelDriver: Driver<RssCellViewModelType> {
        return modelSubject.asDriver(onErrorJustReturn: RssCellViewModel())
    }
    
    var webLoadedSubject = PublishSubject<Bool>()
    
    private func bookmarkedClicked(){
        do {
            let data = try modelSubject.value()
            
            if data.isBookmarked {
                BookmarkDAL.shared.removeBy(title: data.title,complete: self.realmCompletion)
            }else{
                let feed = FeedItem(title: data.title, link: data.link, description: "", pubDate: "", category: [])
                BookmarkDAL.shared.insertBookmark(feed: feed,completion: self.realmCompletion)
            }
        } catch  {
            
        }
    }
    
    func realmCompletion(){
        
        do {
            let data = try self.modelSubject.value()
            self.modelSubject.onNext(data)
        }catch {
            
        }
        
        Notifire.shared().showMessage(message: Message.bookmarkSavedSuccessfully.rawValue, type: .success)
    }
    
}
