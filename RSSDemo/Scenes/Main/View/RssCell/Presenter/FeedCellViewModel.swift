//
//  FeedCellViewModel.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 23/02/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation

struct FeedCellViewModel: RssCellViewModelProtocol {
    
    weak private var parentVM: MainViewModelProtocol?
    private let model: RssViewModelProtocol

    init(parent: MainViewModelProtocol, model: RssViewModelProtocol) {
        self.parentVM = parent
        self.model = model
    }
    
    var isBookmarked: Bool{
        get{ return BookmarkDAL.shared.fetchBy(title: model.title) != nil}
    }
    
    var title: String{
        get{ return model.title}
    }
    
    var link: String{
        get{ return model.link}
    }
    
    var description: String{
        get{ return model.description}
    }
    
    func getModel() -> Any? {
        return model
    }
    
    func getReuseIdentifier() -> String {
        return "CellId"
    }
    
    func nibName() -> String {
        return ""
    }
    
    func bookmarkCell() {
        parentVM?.bookmarkRssCell(model: model)
    }
    
    
}
