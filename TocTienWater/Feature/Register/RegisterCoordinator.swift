//
//  RegisterCoordinator.swift
//  TocTienWater
//
//  Created by Tuan Bui on 14/3/25.
//

import Foundation

final class RegisterCoordinator: BaseCoordinator {
    
    override func start() {
        let registerViewController = RegisterViewController(viewModel: RegisterViewModel())
        registerViewController.coordinator = self
        navigationController.pushViewController(registerViewController, animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}
