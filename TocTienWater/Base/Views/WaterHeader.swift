//
//  WaterHeader.swift
//  TocTienWater
//
//  Created by Nhat on 3/9/25.
//

import UIKit

class WaterHeader: UIView {
    var leftButtonAction: (() -> Void)?
    var rightButtonAction: (() -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        //TODO: move to extension or move to constant
        self.backgroundColor = UIColor(hexString: "#33767d")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(leftButton)
        addSubview(rightButton)
        
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    // Thiết lập constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            leftButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            leftButton.widthAnchor.constraint(equalToConstant: 44),
            leftButton.heightAnchor.constraint(equalToConstant: 44),
            
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightButton.widthAnchor.constraint(equalToConstant: 44),
            rightButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: leftButton.centerYAnchor)
        ])
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setLeftButtonIcon(_ image: UIImage?) {
        leftButton.setImage(image, for: .normal)
    }
    
    func setRightButtonIcon(_ image: UIImage?) {
        rightButton.setImage(image, for: .normal)
    }
    
    func setLeftButtonHidden(_ isHidden: Bool) {
        leftButton.isHidden = isHidden
    }
    
    func setRightButtonHidden(_ isHidden: Bool) {
        rightButton.isHidden = isHidden
    }
    
    @objc private func leftButtonTapped() {
        leftButtonAction?()
    }
    
    @objc private func rightButtonTapped() {
        rightButtonAction?()
    }
}
