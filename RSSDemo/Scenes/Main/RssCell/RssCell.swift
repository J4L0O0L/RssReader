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
    
    private var viewModel : RssCellViewModelType?
    private var tapDisposable: Disposable?
    
    var bookmarkTap : Observable<RssCellViewModelType>{
        return self.badgeBtn.rx.tap.asObservable().map { _ in
            return self.viewModel!
        }
    }
    
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
    
    func configureWith(_ viewModel: MainControllerViewModelType ,model: RssCellViewModelType, index: Int) {
        tapDisposable?.dispose()
        titleLabel.text = model.title
        badgeBtn.setImage(UIImage(named: model.isBookmarked ? "badge-fill" : "badge"), for: .normal)
        tapDisposable = bookmarkTap.map { (IndexPath(row: index, section: 0),$0)}
                           .subscribe(viewModel.bookmarkSelectedSubject)
        self.viewModel = model
        layoutIfNeeded()
    }
}
