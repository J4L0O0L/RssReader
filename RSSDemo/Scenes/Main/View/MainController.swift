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
    
    var tableData: [CellBehavior]?
    
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
        
        viewModel.attachView(self)
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Functions
    private func setupTableView() {
        //tableView.register(RssCell.self, forCellReuseIdentifier: "CellId")
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
    
    private func setupBookmarkBindings(){
        bookmarkButtonItem.rx.tap.bind { _ in
            self.navigationController?.pushViewController(BookmarksController(), animated: true)
        }.disposed(by: disposeBag)
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
}

extension MainController: MainViewProtocol{
    func setTable(_ data: [CellBehavior]) {
        data.forEach({ tableView.register(RssCell.self, forCellReuseIdentifier: $0.getReuseIdentifier())})
        tableData = data
//        let dataSource = ListDataSource(models: data)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
}

extension MainController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableData?[indexPath.row].getReuseIdentifier() ?? "") as? RssCell
        if let dataModel =  tableData?[indexPath.row] {
               cell?.updateCell(item: dataModel)
        }
     
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(DetailController(tableData![indexPath.row] as! RssViewModelProtocol), animated: true)
    }
}
