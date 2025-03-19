//
//  HomeCoordinator.swift
//  TocTienWater
//
//  Created by Nhat on 3/9/25.
//

import UIKit
final class HomeCoordinator: BaseCoordinator {
    var slideMenuVC: SlideMenuViewController?
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
    
    public func showSlideMenu(from viewControllerToPresent: UIViewController) {
        let slideMenuVC = SlideMenuViewController()
        slideMenuVC.modalPresentationStyle = .overCurrentContext
        self.slideMenuVC = slideMenuVC
        viewControllerToPresent.present(slideMenuVC, animated: false) { [weak self] in
            self?.slideMenuVC?.showMenu()
        }
    }
}
