//
//  AppCoordinator.swift
//  TocTienWater
//
//  Created by Nhat on 3/8/25.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    
    override func start() {
        showHomeScreen()
    }
    
    private func showHomeScreen() {
        let homeCoordinator = HomeCoordinator(navigationController: self.navigationController)
        addChild(homeCoordinator)
        homeCoordinator.start()
    }
}
