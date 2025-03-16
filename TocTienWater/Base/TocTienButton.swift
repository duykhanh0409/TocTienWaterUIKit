//
//  TocTienButton.swift
//  TocTienWater
//
//  Created by Nhat on 3/16/25.
//

import UIKit

enum TocTienButtonType {
    case primary
    case warning
}

class TocTienButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 8 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    var typeOfButton: TocTienButtonType = .primary {
        didSet {
            updateAppearance()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        layer.cornerRadius = 8
        clipsToBounds = true
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        updateAppearance()
    }
    
    private func updateAppearance() {
        switch typeOfButton {
        case .primary:
            backgroundColor = .appColor
        case .warning:
            backgroundColor = .systemRed
        }
    }
    
}
