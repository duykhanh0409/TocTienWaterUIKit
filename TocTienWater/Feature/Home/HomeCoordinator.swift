//
//  HomeCoordinator.swift
//  TocTienWater
//
//  Created by Nhat on 3/9/25.
//

import Foundation

final class HomeCoordinator: BaseCoordinator {
    
    override func start() {
        let homeViewController = HomeViewController(viewModel: HomeViewModel())
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    public func goToDetail() {
        self.removeChild(ofType: BillsCoordinator.self)
        let detailCoordinator = BillsCoordinator(navigationController: self.navigationController)
        addChild(detailCoordinator)
        detailCoordinator.start()
    }
}
