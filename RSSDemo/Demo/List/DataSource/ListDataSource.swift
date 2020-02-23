//
//  ListDataSource.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 22/02/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation
import UIKit

class ListDataSource : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var items: [CellBehavior]?
    
    init(models: [CellBehavior]) {
        self.items = models
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: items?[indexPath.row].getReuseIdentifier() ?? "")
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? UpdateCellBehvaior)?.updateCell(item: items![indexPath.row])
    }
    
}

