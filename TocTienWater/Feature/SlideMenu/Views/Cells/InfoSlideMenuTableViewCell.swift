//
//  InfoSlideMenuTableViewCell.swift
//  TocTienWater
//
//  Created by Nhat on 3/17/25.
//

import UIKit

enum TypeInfoView {
    case slideMenu
    case intro
}

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
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    private var actionButtonHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        actionButton.addTarget(self, action: #selector(handleActionButtonTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
        actionButton.addTarget(self, action: #selector(handleActionButtonTap), for: .touchUpInside)
    }
    
    @objc
    private func handleActionButtonTap() {
        if let actionButtonHandler = actionButtonHandler {
            actionButtonHandler()
        }
    }
    
    private func setupUI() {
        self.containerIconView.addSubview(iconImageView)
        containerStackView.addArrangedSubview(containerIconView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(actionButton)
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
        
        NSLayoutConstraint.activate([
            actionButton.widthAnchor.constraint(equalTo: containerStackView.heightAnchor, multiplier: 0.5),
            actionButton.heightAnchor.constraint(equalTo: containerStackView.heightAnchor, multiplier: 0.5)
        ])
    }
    
    
    func configView(icon iconName: String? = nil,
                    title: String,
                    iconButton: String? = nil,
                    type: TypeInfoView,
                    rightButtonAction:(() -> Void)? = nil) {
        if let image = UIImage(named: iconName ?? "") {
            iconImageView.image = image
        } else {
            iconImageView.image = UIImage(systemName: iconName ?? "")
        }
        
        if let imageButton = UIImage(named: iconButton ?? "") {
            actionButton.setImage(imageButton, for: .normal)
        } else {
            let image = UIImage(systemName: iconButton ?? "")
            actionButton.setImage(image, for: .normal)
        }
        
        switch type {
        case .intro:
            titleLabel.textColor = .black
            iconImageView.tintColor = .appColor
            actionButton.tintColor = .appColor
            actionButton.isHidden = false
        default:
            break
        }
        
        self.actionButtonHandler = rightButtonAction
        
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
    
    func configCell(icon iconName: String? = nil,
                    title: String,
                    iconButton: String? = nil,
                    type: TypeInfoView = .slideMenu,
                    rightButtonAction:(() -> Void)? = nil) {
        infoView.configView(icon: iconName,
                            title: title,
                            iconButton: iconButton,
                            type: type)
    }
}
