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

final class MainController: UIViewController {
    
    
    // MARK: - Init and deinit
    init(_ viewModel: MainViewModelProtocol) {
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
    let viewModel: MainViewModelProtocol
    let disposeBag = DisposeBag()
    
    var dataSource: ListDataSource?
    
    // MARK: - UI
    let tableView = UITableView()
    let modeSelectionSegment = UISegmentedControl(items: ["United States", "United Kingdom"])
    let bookmarkButtonItem = UIBarButtonItem.init(
        image: UIImage(named: "bookmarks")?
            .withRenderingMode(.alwaysOriginal),
        style: .plain, target: self,action: nil)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        
        viewModel.attachView(view: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Functions
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(modeSelectionSegment.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupBookmarkButton(){
        self.navigationItem.rightBarButtonItem = bookmarkButtonItem
    }
    
    private func setupModeSelectionSegment() {
        view.addSubview(modeSelectionSegment)
        modeSelectionSegment.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        modeSelectionSegment.selectedSegmentIndex = 1
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "RSS"
        setupModeSelectionSegment()
        setupBookmarkButton()
        setupTableView()
    }
    
    private func setupBindings() {
        setupBookmarkBindings()
        setupModeSelectionSegmentBindings()
    }
    
    private func setupModeSelectionSegmentBindings() {
        modeSelectionSegment.rx
            .selectedSegmentIndex
            .map(FetchTarget.init)
            .flatMap(Utility.ignoreNil)
            .distinctUntilChanged()
            .subscribe(viewModel.modeSelectedSubject)
            .disposed(by: disposeBag)
    }
    
    private func setupBookmarkBindings(){
        bookmarkButtonItem.rx.tap.bind(onNext: gotoBookmarks).disposed(by: disposeBag)
    }
    
    private func gotoBookmarks(){
        navigationController?.pushViewController(BookmarksController(), animated: true)
    }
}

extension MainController: MainViewProtocol{
    func setTable(_ data: [CellBehavior]) {
        data.forEach({ tableView.register(RssCell.self, forCellReuseIdentifier: $0.getReuseIdentifier())})
        dataSource = ListDataSource(models: data, delegate: self)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        reloadTable()
    }
    
    func reloadTable(){
        tableView.reloadData()
    }
    
}

extension MainController: CellSelectDelegate {
    func cellSelected(model: Any) {
        navigationController?.pushViewController(DetailController(model as! RssViewModelProtocol), animated: true)
    }
}
