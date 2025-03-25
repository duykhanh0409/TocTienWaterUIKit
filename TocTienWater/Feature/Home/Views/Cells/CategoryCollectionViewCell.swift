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
        label.translatesAutoresizingMaskIntoConstraints = false // Add this
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
        // Fix stackView constraints to use leading/trailing instead of width
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
        // Fix containerImageView constraints
        NSLayoutConstraint.activate([
            containerImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1),
            containerImageView.heightAnchor.constraint(equalTo: containerImageView.widthAnchor)// Scale relative to cell width
        ])
        
        // Update imageView constraints to scale with container
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerImageView.topAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: containerImageView.bottomAnchor, constant: -8),
            imageView.leadingAnchor.constraint(equalTo: containerImageView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: containerImageView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor) // Keep aspect ratio 1:1
        ])
    }
    
    func configCell(with category: HomeCategory) {
        titleLabel.text = category.rawValue
        imageView.image = UIImage(systemName: category.iconName)
    }
}
