//
//  CategoryCollectionViewCell.swift
//  TocTienWater
//
//  Created by Nhat on 3/13/25.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .appColor
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let containerImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        containerImageView.addSubview(imageView)
        stackView.addArrangedSubview(containerImageView)
        stackView.addArrangedSubview(titleLabel)
        contentView.addSubview(stackView)
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.backgroundColor = UIColor(hexString: "#EDF2F2")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: contentView.bounds.width * 0.8)
        ])
        NSLayoutConstraint.activate([
            containerImageView.widthAnchor.constraint(equalToConstant: stackView.bounds.width),
            containerImageView.heightAnchor.constraint(equalToConstant: 44)
        ])
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 28),
            imageView.widthAnchor.constraint(equalToConstant: 28),
            imageView.centerYAnchor.constraint(equalTo: containerImageView.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: containerImageView.centerXAnchor)
        ])
            
    }
    
    func configCell(with category: HomeCategory) {
        titleLabel.text = category.rawValue
        imageView.image = UIImage(systemName: category.iconName)
    }
}
