//
//  HomeHeaderSectionView.swift
//  TocTienWater
//
//  Created by Nhat on 3/17/25.
//

import UIKit

final class HomeHeaderSectionView: UICollectionReusableView {
    
    private let titleLabelHeader: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        self.addSubview(titleLabelHeader)
        NSLayoutConstraint.activate([
            titleLabelHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleLabelHeader.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func configHeader(with title: String,
                      font: UIFont,
                      textColor: UIColor) {
        self.titleLabelHeader.font = font
        self.titleLabelHeader.textColor = textColor
        self.titleLabelHeader.textAlignment = .center
        self.titleLabelHeader.text = title
    }

}
