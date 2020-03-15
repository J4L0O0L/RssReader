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
import Swinject

final class MainController: UIViewController, MainViewProtocol {
    
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
    let container = Container()
    
    // MARK: - UI
    let containerView = UIView()
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
    }
    
    // MARK: - Functions
    private func setupTableView() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
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
    
    func changeVC(_ vc: UIViewController) {
        children.forEach({$0.removeFromParent()})
        addChild(vc)
        containerView.addSubview(vc.view)
        vc.view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        vc.didMove(toParent: self)
    }
    
    private func changeVcContainer(_ target: Event<FetchTarget>){
        guard self.container.resolve(NetworkServiceProtocol.self) != nil else {
            self.container.register(NetworkServiceProtocol.self) { _ in return NetworkService() }
            changeVcContainer(target)
            return
        }
        
        if container.resolve(RssViewProtocol.self, name: "\(target.element!.hashValue)") == nil {
            container.register(RssViewProtocol.self, name: "\(target.element!.hashValue)") { r in
                
                let vc =  RssController(RssViewModel(networkservice: r.resolve(NetworkServiceProtocol.self)!, selectedMode: target.element!))
                return vc
                
            }
        }
        
        
        let controller =  container.resolve(RssViewProtocol.self , name: "\(target.element!.hashValue)") as! UIViewController
        
        children.forEach({$0.removeFromParent()})
        addChild(controller)
        containerView.addSubview(controller.view)
        controller.view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        controller.didMove(toParent: self)
        
    }
    
    private func gotoBookmarks(){
        navigationController?.pushViewController(BookmarksController(), animated: true)
    }
}

