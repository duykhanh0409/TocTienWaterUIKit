//
//  BillsViewController.swift
//  TocTienWater
//
//  Created by Nhat on 3/9/25.
//

import UIKit

class BillsViewController: BaseViewController {
    weak var coordinator: BillsCoordinator?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        configureHeader(title: "Hoá đơn", leftButtonAction: {
            self.navigationController?.popViewController(animated: true)
        })
        
        tableView.registerCell(BillTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
}

// Mark: TableViewDataSource and Delegate
extension BillsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(BillTableViewCell.self, for: indexPath)
        cell.configCell(day: "20", month: "11", money: 450000, fromValue: 0, toValue: 5)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
