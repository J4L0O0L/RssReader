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
        self.viewModel = BookmarksControllerViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("\(self) dealloc")
    }
    
    // MARK: - Properties
    let viewModel: BookmarksControllerViewModelType
    let disposeBag = DisposeBag()
    
    // MARK: - UI
    let tableView = UITableView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
    }
    
    // MARK: - Functions
    private func setupTableView() {
        tableView.register(BookmarkCell.self, forCellReuseIdentifier: "BookmarkCell")
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
        setupTableViewBindings()
    }
    
    private func setupTableViewBindings() {
        
        viewModel.cellViewModelsDriver
            .drive(tableView.rx.items) { tableView, row, viewModel in
                let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkCell") as! BookmarkCell
                cell.configureWith(viewModel, index: row)
                return cell
        }.disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(BookmarkCellViewModelProtocol.self)
            .do(onNext: { _ in self.tableView.indexPathsForSelectedRows?.forEach { self.tableView.deselectRow(at: $0, animated: true) }})
            .subscribe(onNext: {self.tableCellSelected($0)})
            .disposed(by: disposeBag)
        
        
    }
    
    private func tableCellSelected(_ viewModel: BookmarkCellViewModelProtocol){
        navigationController?.pushViewController(DetailController(DetailControllerViewModel(RssCellViewModel(FeedItem(title: viewModel.title, link: viewModel.link, description: viewModel.description, pubDate: "", category: [])))), animated: true)
    }
}

