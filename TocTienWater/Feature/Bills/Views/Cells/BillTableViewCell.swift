//
//  BillTableViewCell.swift
//  TocTienWater
//
//  Created by Nhat on 3/30/25.
//

import UIKit

class BillTableViewCell: UITableViewCell {
    
    private let dateLabel: UnitLabel = {
        let label = UnitLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let m3Label: UnitLabel = {
        let label = UnitLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moneyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subContentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        containerStackView.addArrangedSubview(dateLabel)
        subContentStackView.addArrangedSubview(moneyLabel)
        subContentStackView.addArrangedSubview(descriptionLabel)
        containerStackView.addArrangedSubview(subContentStackView)
        containerStackView.addArrangedSubview(m3Label)
        self.contentView.addSubview(containerStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.widthAnchor.constraint(equalTo: self.containerStackView.heightAnchor),
            dateLabel.heightAnchor.constraint(equalTo: self.containerStackView.heightAnchor),
            m3Label.widthAnchor.constraint(equalTo: self.containerStackView.heightAnchor),
            m3Label.heightAnchor.constraint(equalTo: self.containerStackView.heightAnchor)
        ])
    }
    
    func configCell(day: String,
                    month: String,
                    money: Double,
                    fromValue: Float,
                    toValue: Float) {
        dateLabel.configLabel(value: month, unit: day)
        m3Label.configLabel(value: Utils.shared.formatNumber(toValue - fromValue), unit: "m3")
        moneyLabel.text = "Tổng số tiền: \(Utils.shared.formatNumber(money)) VNĐ"
        descriptionLabel.text = "Chỉ số từ \(Utils.shared.formatNumber(fromValue)) đến \(Utils.shared.formatNumber(toValue))"
    }
}
