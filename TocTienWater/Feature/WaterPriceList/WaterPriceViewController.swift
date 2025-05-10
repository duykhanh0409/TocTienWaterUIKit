//
//  WaterPriceViewController.swift
//  TocTienWater
//
//  Created by Bui Tuan on 31/3/25.
//

import UIKit

class WaterPriceViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var yearListView: UIView?
    
    @IBOutlet weak var titleLabel: UILabel!
    weak var coordinator: WaterPriceCoordinator?
    let viewModel: WaterPriceViewModel
    
    init(viewModel: WaterPriceViewModel) {
        self.viewModel = viewModel
        super.init()
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeader(title: "Bảng giá nước",
                        leftButtonIcon: "chevron.left",
                        rightButtonIcon: UIImage(named: "icon_more"),
                        showRightButton: true,
                        leftButtonAction: { [weak self] in
            self?.coordinator?.back()
        },
                        rightButtonAction: { [weak self] in
            self?.showMoreView()
        })
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(WaterPriceCell.self)
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTap(_:)))
        tableView.addGestureRecognizer(tapGesture)
        setBinding()
        viewModel.fetchData()
    }

    private func showMoreView() {
        if yearListView == nil {
            addYearList()
        } else {
            self.yearListView?.isHidden = !(self.yearListView?.isHidden ?? false)
        }
    }
    
    private func addYearList() {
        let yearListView = UIView()
        yearListView.backgroundColor = UIColor(hexString: "#EFF5F5")
        yearListView.layer.cornerRadius = 8
        yearListView.translatesAutoresizingMaskIntoConstraints = false
        
        let years = ["2024 - nay", "2018 - 2023", "2017", "2016", "2015", "2013-2014"]
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        yearListView.addSubview(stackView)
        yearListView.isHidden = false
        
        for year in years {
            let yearView = UIView()
            let label = UILabel()
            label.text = year
            label.textAlignment = .center
            
            yearView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: yearView.topAnchor),
                label.leadingAnchor.constraint(equalTo: yearView.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: yearView.trailingAnchor),
                label.bottomAnchor.constraint(equalTo: yearView.bottomAnchor)
            ])
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(yearTapped(_:)))
            yearView.addGestureRecognizer(tapGesture)
            yearView.isUserInteractionEnabled = true
            
            stackView.addArrangedSubview(yearView)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: yearListView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: yearListView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: yearListView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: yearListView.bottomAnchor, constant: -8)
        ])
        
        view.addSubview(yearListView)
        NSLayoutConstraint.activate([
            yearListView.widthAnchor.constraint(equalToConstant: 150),
            yearListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            yearListView.topAnchor.constraint(equalTo: customHeaderView.bottomAnchor, constant: 0)
        ])
        yearListView.layer.shadowColor = UIColor.black.cgColor
        yearListView.layer.shadowOffset = CGSize(width: 0, height: 2)
        yearListView.layer.shadowOpacity = 0.5
        yearListView.layer.shadowRadius = 4
        yearListView.layer.masksToBounds = false
        self.yearListView = yearListView
    }
    
    @objc func showYearList() {
        self.yearListView?.isHidden = false
    }
    
    @objc func tableViewTap(_ sender: UITapGestureRecognizer) {
        self.yearListView?.isHidden = true
    }
    
    @objc func yearTapped(_ sender: UITapGestureRecognizer) {
        if let yearView = sender.view, let label = yearView.subviews.first as? UILabel, let year = label.text {
            print("Năm được chọn: \(year)")
            titleLabel.text = year
            self.yearListView?.isHidden = true
        }
    }
    
    private func setBinding() {
        viewModel.dataSourcePublisher
            .sink { _ in
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

// MARK: - UITableViewDataSource
extension WaterPriceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getDataCell().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(WaterPriceCell.self, for: indexPath)
        let option = viewModel.getDataCell()[indexPath.row]
        cell.configure(option: option)
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WaterPriceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let option = viewModel.getDataCell()[indexPath.row]
        switch option.options.count {
        case 2:
            return 80
        case 3:
            return 100
        default:
            return 60
        }
    }
}
