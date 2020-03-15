//
//  MainVC.swift
//  RSSDemo
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class BookmarksController: UIViewController {
    
    // MARK: - Init and deinit
    init() {
        self.viewModel = BookmarksViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("\(self) dealloc")
    }
    
    // MARK: - Properties
    let viewModel: BookmarkViewModelProtocol
    let disposeBag = DisposeBag()
    
    var dataSource: ListDataSource?
    
    // MARK: - UI
    let tableView = UITableView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        
        viewModel.attachView(view: self)
    }
    
    // MARK: - Functions
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "Bookmarks"
    }
}

extension BookmarksController: BookmarkViewProtocol{
    func loadBookmarks(_ bookmarks: [CellBehavior]) {
        bookmarks.forEach({ tableView.register(BookmarkCell.self, forCellReuseIdentifier: $0.getReuseIdentifier())})
        dataSource = ListDataSource(models: bookmarks, delegate: self)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
}

extension BookmarksController: CellSelectDelegate {
    func cellSelected(model: Any) { navigationController?.pushViewController(DetailController(model as! RssViewModelProtocol, delegate: self), animated: true)
    }
}


extension BookmarksController: DetailViewDelegate {
    func rssBookmarked(model: RssViewModelProtocol) {
        viewModel.loadBookmarks()
    }
}
