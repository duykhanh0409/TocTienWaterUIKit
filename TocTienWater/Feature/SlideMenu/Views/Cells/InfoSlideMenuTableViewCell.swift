//
//  InfoSlideMenuTableViewCell.swift
//  TocTienWater
//
//  Created by Nhat on 3/17/25.
//

import UIKit

class InfoView: UIView {
    private let containerIconView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        self.containerIconView.addSubview(iconImageView)
        containerStackView.addArrangedSubview(containerIconView)
        containerStackView.addArrangedSubview(titleLabel)
        addSubview(containerStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: containerIconView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: containerIconView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalTo: containerStackView.heightAnchor, multiplier: 0.5),
            iconImageView.heightAnchor.constraint(equalTo: containerStackView.heightAnchor, multiplier: 0.5),
            containerIconView.widthAnchor.constraint(equalTo: containerStackView.heightAnchor),
            containerIconView.heightAnchor.constraint(equalTo: containerStackView.heightAnchor)
        ])
    }
    
    
    func configView(icon iconName: String? = nil,
                    title: String) {
        if let image = UIImage(named: iconName ?? "") {
            iconImageView.image = image
        } else {
            iconImageView.image = UIImage(systemName: iconName ?? "")
        }
        
        titleLabel.text = title
    }
}

class InfoSlideMenuTableViewCell: UITableViewCell {
    private let infoView: InfoView = {
        let view = InfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        self.contentView.addSubview(infoView)
        self.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4),
            infoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            infoView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 4),
            infoView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
    
    func configView(with iconName: String? = nil,
                    title: String) {
        infoView.configView(icon: iconName,
                            title: title)
    }
}
