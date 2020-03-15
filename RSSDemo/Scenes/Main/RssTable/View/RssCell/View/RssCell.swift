//
//  RssCell.swift
//  RSSDemo
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import UIKit
import RxSwift

class RssCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let badgeBtn = UIButton(type: .custom)
    
    private var viewModel : RssCellViewModelProtocol?
    
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
        
        badgeBtn.addTarget(self, action: #selector(bookmarkTapped), for: .touchUpInside)
    }
    
    private func layoutUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(badgeBtn)
        
        badgeBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-5)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(5)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-50)
            make.top.equalToSuperview().offset(15)
        }
        
        
    }
    
    @objc func bookmarkTapped(_ target: Any){
        viewModel?.bookmarkCell()
    }
    
}

extension RssCell: UpdateCellBehvaior{
    func updateCell(item: CellBehavior) {
        if let model = item as? RssCellViewModelProtocol {
            viewModel = model
            titleLabel.text = model.title
            badgeBtn.setImage(UIImage(named: model.isBookmarked ? "badge-fill" : "badge"), for: .normal)
        }
        
    }
    
}
