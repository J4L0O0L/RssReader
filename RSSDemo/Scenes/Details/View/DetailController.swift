//
//  DetailController.swift
//  RSSDemo
//
//  Created by Mohammdereza Jalilvand on 22/01/2020.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import WebKit

final class DetailController: UIViewController {
    
    // MARK: - Init and deinit
    init(_ data: RssViewModelProtocol) {
        viewModel = DetailViewModel(data: data)
        super.init(nibName: nil, bundle: nil)
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(self) dealloc")
    }
    
    // MARK: - Properties
    var viewModel : DetailViewModelProtocol
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
        setupBookmarkButtonBinding()
        
        viewModel.attachView(view: self)
    }
    
    // MARK: - Functions
    fileprivate func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = ""
        
        setupWebView()
    }
    
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
    
    private func setupBookmarkButtonBinding(){
        bookmarkButton.rx.tap.bind(to: viewModel.bookmarkedSelection).disposed(by: disposeBag)
    }
    
}

extension DetailController: DetailViewProtocol {
    func loadUrl(url: String) {
        if let url = URL(string: url){
            self.webView.load(URLRequest(url: url))
        }
    }
    
    func setRssDetail(data: RssViewModelProtocol) {
        navigationItem.title = data.title
        
        bookmarkButton.setBackgroundImage(UIImage(named: data.isBookmarked ? "badge-fill" : "badge")?
            .withRenderingMode(.alwaysOriginal), for: .normal, style: .plain, barMetrics: .default)
        navigationItem.rightBarButtonItem = bookmarkButton
    }
    
    
}

extension DetailController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    {
        print("loadingCompleted")
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
