//
//  WaterPriceCoordinator.swift
//  TocTienWater
//
//  Created by Bui Tuan on 31/3/25.
//

import Foundation

final class WaterPriceCoordinator: BaseCoordinator {
    
    override func start() {
        let waterPriceViewViewController = WaterPriceViewController(viewModel: WaterPriceViewModel())
        waterPriceViewViewController.coordinator = self
        navigationController.pushViewController(waterPriceViewViewController, animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}
