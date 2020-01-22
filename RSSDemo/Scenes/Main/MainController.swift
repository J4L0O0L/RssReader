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
    init(_ viewModel: MainControllerViewModelType) {
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
    let viewModel: MainControllerViewModelType
    let disposeBag = DisposeBag()
    
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
    }
    
    // MARK: - Functions
    private func setupTableView() {
        tableView.register(RssCell.self, forCellReuseIdentifier: "RssCell")
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
        navigationItem.title = "Main controller"
        setupModeSelectionSegment()
        setupBookmarkButton()
        setupTableView()
    }
    
    private func setupBindings() {
        setupTableViewBindings()
        setupBookmarkBindings()
        setupModeSelectionSegmentBindings()
    }
    
    private func setupBookmarkBindings(){
        bookmarkButtonItem.rx.tap.bind { _ in
            //navigationController?.pushViewController(DetailController(DetailControllerViewModel(viewModel.link)), animated: true)
        }.disposed(by: disposeBag)
    }
    
    private func setupModeSelectionSegmentBindings() {
        modeSelectionSegment.rx
            .selectedSegmentIndex
            .asObservable()
            .map(FetchTarget.init)
            .flatMap(Utility.ignoreNil)
            .distinctUntilChanged()
            .subscribe(viewModel.modeSelectedSubject)
            .disposed(by: disposeBag)
    }
    
    private func setupTableViewBindings() {
        
        viewModel.cellViewModelsDriver
            .drive(tableView.rx.items) { tableView, row, viewModel in
                let cell = tableView.dequeueReusableCell(withIdentifier: "RssCell") as! RssCell
                cell.bookmarkTap.subscribe(self.viewModel.bookmarkSelectedSubject).disposed(by: self.disposeBag)
                cell.configureWith(viewModel, index: row)
                return cell
        }.disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(RssCellViewModelType.self)
            .do(onNext: { _ in self.tableView.indexPathsForSelectedRows?.forEach { self.tableView.deselectRow(at: $0, animated: true) }})
            .subscribe(onNext: {self.tableCellSelected($0)})
            .disposed(by: disposeBag)
        
        
        viewModel.cellUpdatedDriver
            .subscribe(onNext: { cellViewModel in
               
            }).disposed(by: disposeBag)
        
    }
    
    private func tableCellSelected(_ viewModel: RssCellViewModelType){
        navigationController?.pushViewController(DetailController(DetailControllerViewModel(viewModel.link)), animated: true)
    }
}

