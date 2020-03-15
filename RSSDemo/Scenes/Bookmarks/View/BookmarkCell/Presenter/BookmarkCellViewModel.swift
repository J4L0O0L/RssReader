//
//  RssCellViewModel.swift
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation

struct BookmarkCellViewModel: BookmarkCellViewModelProtocol {
    
    private let model: Bookmark
    
    init(model: Bookmark) {
        self.model = model
    }
    
    var isBookmarked = true
    
    func getModel() -> Any? {
        return model
    }
    
    func getReuseIdentifier() -> String {
        return "CellId"
    }
    
    func nibName() -> String {
        return ""
    }
    
    var link: String{
        get{ return model.link ?? ""}
    }
    
    var description: String{
        get{ return model.description }
    }
    
    var title: String {
        get{ return model.title ?? ""}
    }
    
}
