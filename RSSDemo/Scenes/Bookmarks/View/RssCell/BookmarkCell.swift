//
//  RssCell.swift
//  RSSDemo
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import UIKit
import RxSwift

class BookmarkCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    
    private var viewModel : BookmarkCellViewModelProtocol?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard contentView.subviews.isEmpty else {
            return
        }
        setupUI()
        layoutUI()
    }
    
    private func setupUI() {
        //Label setup
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.numberOfLines = 1
    }
    
    private func layoutUI() {
        contentView.addSubview(titleLabel)
       
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-50)
            make.top.equalToSuperview().offset(15)
        }
    }
    
    func configureWith(_ viewModel: BookmarkCellViewModelProtocol, index: Int) {
        titleLabel.text = viewModel.title
        self.viewModel = viewModel
        layoutIfNeeded()
    }
}
