//
//  GeneralListView.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 22/02/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation
import UIKit

class GeneralListView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    func displayList(items: [CellBehavior]) {
        registerCells(items: items)
        
        let dataSource = ListDataSource(models: items)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
    }
    
    func registerCells(items: [CellBehavior]) {
        items.forEach({ tableView.register(UINib.init(nibName: $0.nibName(), bundle: nil), forCellReuseIdentifier: $0.getReuseIdentifier())})
    }
}
