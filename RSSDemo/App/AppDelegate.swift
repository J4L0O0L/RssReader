//
//  AppDelegate.swift
//  RSSDemo
//
//  Created by Arthur Myronenko on 6/29/17.
//  Copyright © 2017 UPTech Team. All rights reserved.
//

import UIKit
import RxSwift
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let disposeBag = DisposeBag()
    
    let container = Container() { container in
        // Services
        container.register(NetworkService.self) { _ in BasicNetworkService() }
        
        // View models
        container.register(MainControllerViewModelType.self) { r in
            let viewModel = MainControllerViewModel(r.resolve(NetworkService.self)!)
            return viewModel
        }.inObjectScope(.container)
        
        // Views
        container.register(MainController.self) { r in
            let vc = MainController(r.resolve(MainControllerViewModelType.self)!)
            return vc
        }
        
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        navigationController.setViewControllers([container.resolve(MainController.self)!], animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
