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
    private let viewModel: IntroduceViewModelProtocol
    
    init(viewModel: IntroduceViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
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
    
    private func setupBinding() {
        viewModel.dataSourcePublisher
            .sink { _ in
                self.tableView.reloadData()
            }.store(in: &cancellables)
    }
}

// Mark: Tableview Datasource and delegate
extension IntroduceViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.getData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = self.viewModel.getData()[indexPath.row]
        let cell = tableView.dequeueCell(InfoSlideMenuTableViewCell.self, for: indexPath)
        cell.configCell(with: type, typeView: .intro) { [weak self] in
            guard let self = self else { return }
            self.handleTapAction(with: type)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }
}

extension IntroduceViewController {
    private func handleTapAction(with type: IntroduceType) {
        Utils.shared.openURL(with: type)
    }
}
