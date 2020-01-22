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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupWebViewBindings()
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
        navigationItem.title = "Detail controller"
        setupWebView()
    }
    
    private func setupWebViewBindings() {
        viewModel.linkDriver
            .drive(onNext: { linkStr in
                if let url = URL(string: linkStr){
                    self.webView.load(URLRequest(url: url))
                }
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
