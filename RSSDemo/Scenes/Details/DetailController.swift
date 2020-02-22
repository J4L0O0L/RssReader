//
//  DetailController.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 22/01/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import WebKit

final class DetailController: UIViewController {
    
    // MARK: - Init and deinit
    init(_ viewModel: DetailControllerViewModelType) {
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
    let viewModel: DetailControllerViewModelType
    let disposeBag = DisposeBag()
    
    // MARK: - UI
    var webView = WKWebView()
    var bookmarkButton = UIBarButtonItem.init(
                    image: UIImage(named: "badge")?
                        .withRenderingMode(.alwaysOriginal),
                    style: .plain, target: self,action: nil)
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupWebViewBindings()
        setupBookmarkButtonBinding()
    }
    
    // MARK: - Functions
    private func setupWebView() {
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = ""
        
        setupWebView()
    }
    
    private func setupBookmarkButtonBinding(){
        bookmarkButton.rx.tap.bind(to: viewModel.bookmarkedSelection).disposed(by: disposeBag)
    }
    
    private func setupWebViewBindings() {
        viewModel.linkDriver.drive(onNext: { linkStr in
            if let url = URL(string: linkStr){
                self.webView.load(URLRequest(url: url))
            }
        }).disposed(by: disposeBag)
        
        viewModel.modelDriver.map({$0.title})
            .drive(onNext: { title in
                self.navigationItem.title = title
            }).disposed(by: disposeBag)
        
        viewModel.modelDriver.map({$0.isBookmarked})
            .drive(onNext: { isBookmarked in
                self.bookmarkButton.setBackgroundImage(UIImage(named: isBookmarked ? "badge-fill" : "badge")?
                    .withRenderingMode(.alwaysOriginal), for: .normal, style: .plain, barMetrics: .default)
//                    = UIBarButtonItem.init(
//                image: UIImage(named: isBookmarked ? "badge-fill" : "badge")?
//                    .withRenderingMode(.alwaysOriginal),
//                style: .plain, target: self,action: nil)
                self.navigationItem.rightBarButtonItem = self.bookmarkButton
            }).disposed(by: disposeBag)
    }
}

extension DetailController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    {
        viewModel.webLoadedSubject.onNext(true)
    }
   
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
       print(error)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }
}
