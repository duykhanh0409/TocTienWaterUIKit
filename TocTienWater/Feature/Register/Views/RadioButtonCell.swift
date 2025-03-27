//
//  RadioButtonCell.swift
//  TocTienWater
//
//  Created by Tuan Bui on 17/3/25.
//

import UIKit

protocol RadioButtonCellDelegate: AnyObject {
    func selelectButton(options: CustomerType)
    func selelectButton(options: WaterUsagePurpose)
}

class RadioButtonCell: UITableViewCell {
    let label = UILabel()
    var buttons: [UIButton] = []
    var stackView = UIStackView()
    weak var delegate: RadioButtonCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        buttons = []
    }
    
    func configCell<T>(label: String, options: [T], selected: T) {
        // Remove all previous subviews to ensure a clean state
        contentView.subviews.forEach { $0.removeFromSuperview() }

        // Set up label
        self.label.text = label
        self.label.font = .systemFont(ofSize: 14)
        contentView.addSubview(self.label)

        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        self.label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        self.label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true

        // Create buttons for options
        buttons = options.map { item in
            let button = UIButton()
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.backgroundColor = .white
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 4
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            button.setAssociatedObject(item)

            if let customerType = item as? CustomerType {
                button.setTitle(customerType.title, for: .normal)
                if let selected = selected as? CustomerType, customerType == selected {
                    button.backgroundColor = UIColor(hexString: "#2B6469")
                    button.setTitleColor(.white, for: .normal)
                    button.layer.borderColor = nil
                }
            } else if let waterUsagePurpose = item as? WaterUsagePurpose {
                button.setTitle(waterUsagePurpose.title, for: .normal)
                if let selected = selected as? WaterUsagePurpose, waterUsagePurpose == selected {
                    button.backgroundColor = UIColor(hexString: "#2B6469")
                    button.setTitleColor(.white, for: .normal)
                    button.layer.borderColor = nil
                }
            }

            button.addTarget(self, action: #selector(selectedButton(_:)), for: .touchUpInside)
            return button
        }

        // Create UIScrollView and stackView
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        contentView.addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 8).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: 40).isActive = true

        stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.spacing = 8
        scrollView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    }
    
    @objc func selectedButton(_ sender: UIButton) {
        for item in buttons {
            item.backgroundColor = .white
            item.layer.borderColor = UIColor.black.cgColor
            item.layer.borderWidth = 1
            item.setTitleColor(.black, for: .normal)
        }

        sender.backgroundColor = UIColor(hexString: "#2B6469")
        sender.setTitleColor(.white, for: .normal)
        sender.layer.borderColor = nil

        if let customerType: CustomerType = sender.getAssociatedObject() {
            delegate?.selelectButton(options: customerType)
        }

        if let waterUsagePurpose: WaterUsagePurpose = sender.getAssociatedObject() {
            delegate?.selelectButton(options: waterUsagePurpose)
        }
    }
}
