//
//  SlideMenuViewController.swift
//  TocTienWater
//
//  Created by Nhat on 3/17/25.
//

import UIKit

protocol SlideMenuCoordinatorDelegate: AnyObject {
    func didDismissSlideMenu()
}

class SlideMenuViewController: UIViewController {
    // Mark: Variable
    weak var delegate: SlideMenuCoordinatorDelegate?
    
    private let menuWidth: CGFloat = 250
    private let overlayView = UIView()
    private let menuView = UIView()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private let authenView: InfoView = {
        let view = InfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configView(icon: "enter_icon",
                        title: "Đăng Nhập")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOverlayView()
        setupMenuView()
        setupConstants()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
    
    private func setupOverlayView() {
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlayView.frame = view.bounds
        overlayView.isUserInteractionEnabled = true
        overlayView.alpha = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissMenu))
        overlayView.addGestureRecognizer(tap)
        view.addSubview(overlayView)
    }
    
    private func setupMenuView() {
        menuView.backgroundColor = .appColor
        menuView.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.bounds.height)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(InfoSlideMenuTableViewCell.self)
        tableView.registerCell(NotAuthenTableViewCell.self)
        menuView.addSubview(authenView)
        menuView.addSubview(tableView)
        view.addSubview(menuView)
    }
    
    private func setupConstants() {
        
        NSLayoutConstraint.activate([
            authenView.bottomAnchor.constraint(equalTo: menuView.bottomAnchor),
            authenView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 4),
            authenView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
            authenView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: menuView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: authenView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor)
        ])
    }
    
    func showMenu() {
        UIView.animate(withDuration: 0.3) {
            self.menuView.frame.origin.x = 0
            self.overlayView.alpha = 1
        }
    }
    
    @objc func dismissMenu() {
        UIView.animate(withDuration: 0.3) {
            self.menuView.frame.origin.x = -self.menuWidth
            self.overlayView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.delegate?.didDismissSlideMenu()
        }
    }
}

// Mark: TableViewDatasoure & TableViewDelegate
extension SlideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueCell(NotAuthenTableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueCell(InfoSlideMenuTableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            cell.configView(with: "building.2",
                            title: "Ấp 6, Xã Tóc Tiên, Thị xã Phú Mỹ\nBà Rịa - Vũng Tàu")
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return UITableView.automaticDimension
        default:
            return 36
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear

        let label = UILabel()
        label.text = "PHẠM NGỌC CHÍ"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false

        headerView.addSubview(label)

        // Thiết lập constraints cho label
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor)
        ])

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}
