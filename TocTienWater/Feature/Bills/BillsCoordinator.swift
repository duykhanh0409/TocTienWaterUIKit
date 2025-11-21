

import Foundation

final class BillsCoordinator: BaseCoordinator {
    override func start() {
        let billViewController = BillsViewController()
        billViewController.coordinator = self
        self.navigationController.pushViewController(billViewController, animated: true)
    }
}
