//
//  WaterPriceCell.swift
//  TocTienWater
//
//  Created by Bui Tuan on 31/3/25.
//

import UIKit

class WaterPriceCell: UITableViewCell {
    let stackView = UIStackView()
    let iconImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(option: WaterPriceCategory) {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = UIImage(named: "icon_water")
        contentView.addSubview(iconImageView)
       
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16), // Leading edge
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor), // Vertical center
            iconImageView.widthAnchor.constraint(equalToConstant: 24), // Width 24
            iconImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        let titleLabel = UILabel()
        titleLabel.text = option.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        
        for item in option.options {
            let descriptionLabel = UILabel()
            descriptionLabel.text = item.description
            descriptionLabel.font = UIFont.systemFont(ofSize: 12)

            let valueLabel = UILabel()
            valueLabel.text = item.price
            valueLabel.font = UIFont.systemFont(ofSize: 12)
            valueLabel.textAlignment = .right

            let optionStackView = UIStackView()
            optionStackView.axis = .horizontal
            optionStackView.spacing = 8
            optionStackView.addArrangedSubview(descriptionLabel)
            optionStackView.addArrangedSubview(valueLabel)

            stackView.addArrangedSubview(optionStackView)
            
            contentView.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                stackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
                stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            ])
        }
    }
}
