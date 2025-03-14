//
//  DetailCoordinator.swift
//  TocTienWater
//
//  Created by Nhat on 3/9/25.
//

import Foundation

final class BillsCoordinator: BaseCoordinator {
    override func start() {
        let billViewController = BillsViewController()
        billViewController.coordinator = self
        self.navigationController.pushViewController(billViewController, animated: true)
    }
}
