//
//  Coordinator.swift
//  TocTienWater
//
//  Created by Nhat on 3/8/25.
//

import UIKit
protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var childCoordinators: [Coordinator] { get }
    func start()
    func addChild(_ coordinator: Coordinator)
    func removeChild(_ coordinator: Coordinator)
    func removeChild<T: Coordinator>(ofType type: T.Type)
    func removeAllChildrenCoordinator()
}
