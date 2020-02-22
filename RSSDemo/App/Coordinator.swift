//
//  Coordinator.swift
//  networkTest
//
//  Created by M4RJ4N on 1/20/20.
//  Copyright © 2020 Alexey Savchenko. All rights reserved.
//

import UIKit

protocol Coordinator: class {
  var rootViewController: UIViewController { get }
  var childCoordinators: [Coordinator] { get set }
  func start(initController: UIViewController)
}

extension Coordinator {
  func addChildCoordinator(_ coordinator: Coordinator) {
    childCoordinators.append(coordinator)
  }

  func removeChildCoordinator(_ coordinator: Coordinator) {
    self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
  }
}
