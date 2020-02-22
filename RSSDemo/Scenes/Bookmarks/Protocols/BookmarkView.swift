//
//  BookmarkView.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 22/02/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation

protocol BookmarkView: class {
    func loadBookmarks(bookmarks: [CellBehavior])
}
