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
    
    public func gotoIntroduceVC() {
        self.removeChild(ofType: IntroduceCoordinator.self)
        let introduceCoordinator = IntroduceCoordinator(navigationController: self.navigationController)
        addChild(introduceCoordinator)
        introduceCoordinator.start()
    }
    
    public func showSlideMenu(from viewControllerToPresent: UIViewController) {
        let slideMenuVC = SlideMenuViewController()
        slideMenuVC.modalPresentationStyle = .overCurrentContext
        self.slideMenuVC = slideMenuVC
        viewControllerToPresent.present(slideMenuVC, animated: false) { [weak self] in
            self?.slideMenuVC?.showMenu()
        }
    }
    
    public func goToRegister() {
        self.removeChild(ofType: RegisterCoordinator.self)
        let registerCoordinator = RegisterCoordinator(navigationController: self.navigationController)
        addChild(registerCoordinator)
        registerCoordinator.start()
    }
    
    
    public func goToBillVc() {
        self.removeChild(ofType: BillsCoordinator.self)
        let billsCoordinator = BillsCoordinator(navigationController: self.navigationController)
        addChild(billsCoordinator)
        billsCoordinator.start()
    }
}
