//
//  IntroduceViewController.swift
//  TocTienWater
//
//  Created by Nhat on 3/21/25.
//

import UIKit

class IntroduceViewController: BaseViewController {
    // Mark: Outlet
    @IBOutlet weak var tableView: UITableView!
    // Mark: Properties
    weak var coordinator: IntroduceCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        configureHeader(title: "Giới thiệu",
                        leftButtonIcon: "chevron.left",
                        leftButtonAction: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        })
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(InfoSlideMenuTableViewCell.self)
        tableView.separatorStyle = .none
    }
}

// Mark: Tableview Datasource and delegate
extension IntroduceViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(InfoSlideMenuTableViewCell.self, for: indexPath)
        cell.configCell(icon: "building.2",
                        title: "Ấp 6, Xã Tóc Tiên, Thị xã Phú Mỹ\nBà Rịa - Vũng Tàu",
                        iconButton: "building.2",
                        type: .intro)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32
    }
}
