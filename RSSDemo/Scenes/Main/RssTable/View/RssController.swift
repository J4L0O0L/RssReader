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

final class RssController: UIViewController {
    
    
    // MARK: - Init and deinit
    init(_ viewModel: RssTableViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(self) dealloc")
    }
    
    // MARK: - Properties
    let viewModel: RssTableViewModelProtocol
    let disposeBag = DisposeBag()
    
    var dataSource: ListDataSource?
    
    // MARK: - UI
    let tableView = UITableView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        viewModel.attachView(view: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Functions
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        setupTableView()
    }
}

extension RssController: RssViewProtocol{
    func setTable(_ data: [CellBehavior]) {
        data.forEach({ tableView.register(RssCell.self, forCellReuseIdentifier: $0.getReuseIdentifier())})
        dataSource = ListDataSource(models: data, delegate: self)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    func reloadTable(_ data: [CellBehavior]){
        dataSource?.items = data
        tableView.reloadData()
    }
    
}

extension RssController: CellSelectDelegate {
    func cellSelected(model: Any) {
        navigationController?.pushViewController(DetailController(model as! RssViewModelProtocol, delegate:  self), animated: true)
    }
}

extension RssController: DetailViewDelegate {
    func rssBookmarked(model: RssViewModelProtocol) {
        viewModel.realmCompletion(model)
    }
}
