//
//  AppCoordinator.swift
//  networkTest
//
//  Created by M4RJ4N on 1/20/20.
//  Copyright © 2020 Alexey Savchenko. All rights reserved.
//
import UIKit

/// Main app coordinator that manages basic app flow
class AppCoordinator: Coordinator {
    
    // Init and deinit
    init(_ window: UIWindow) {
        self.window = window
    }
    
    deinit {
        print("\(self) dealloc")
    }
    
    // MARK: Properties
    private let navigationController = UINavigationController()
    private let window: UIWindow
    var rootViewController: UIViewController {
        return navigationController
    }
    
    var childCoordinators = [Coordinator]()
    
    // MARK: Functions
    func start(initController: UIViewController) {
        navigationController.setViewControllers([initController], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: NavigationDelegate {
    func RssCellSelected(_ viewModel: RssCellViewModelType) {
        let controller: UIViewController =
        navigationController.pushViewController(controller, animated: true)
    }
}
