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
    var cellSelectionDelegate: CellSelectDelegate?
    
    init(models: [CellBehavior], delegate: CellSelectDelegate) {
        self.items = models
        self.cellSelectionDelegate = delegate
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        cellSelectionDelegate?.cellSelected(model: items?[indexPath.row] ?? "")
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

