//
//  IntroduceCoordinator.swift
//  TocTienWater
//
//  Created by Nhat on 3/21/25.
//

import Foundation

final class IntroduceCoordinator: BaseCoordinator {
    
    override func start() {
        let introduceVC = IntroduceViewController(viewModel: IntroduceViewModel())
        introduceVC.coordinator = self
        navigationController.pushViewController(introduceVC, animated: true)
    }
}
