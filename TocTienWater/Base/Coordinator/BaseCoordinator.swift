//
//  BaseCoordinator.swift
//  TocTienWater
//
//  Created by Nhat on 3/9/25.
//

import UIKit

class BaseCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        fatalError("Subclasses must implement start")
    }
    
    func addChild(_ coordinator: any Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChild(_ coordinator: any Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
    
    
    func removeAllChildrenCoordinator() {
        childCoordinators.removeAll()
    }
    
    func removeChild<T>(ofType type: T.Type) where T : Coordinator {
        childCoordinators.removeAll { $0 is T }
    }
}
