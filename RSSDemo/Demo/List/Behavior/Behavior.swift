//
//  Behavior.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 22/02/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation

protocol CellBehavior {
    
    func getModel() -> Any?
    func getReuseIdentifier() -> String
    func nibName() -> String
    
}


protocol UpdateCellBehvaior {
    func updateCell(item: CellBehavior)
}
