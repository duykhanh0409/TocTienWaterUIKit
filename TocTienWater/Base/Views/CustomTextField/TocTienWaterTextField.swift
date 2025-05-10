//
//  TocTienWaterTextField.swift
//  TocTienWater
//
//  Created by Nhat on 3/15/25.
//

import UIKit

protocol TocTienWaterTextFieldDelegate: AnyObject {
    func textFieldDidBeginEditing(_ textField: TocTienWaterTextField)
    func textFieldDidEndEditing(_ textField: UITextField)
}

extension TocTienWaterTextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: TocTienWaterTextField){}
    func textFieldDidEndEditing(_ textField: UITextField) {}
}

final class TocTienWaterTextField: UIView {
    
    weak var delegate: TocTienWaterTextFieldDelegate?

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        return imageView
    }()
    
    private let containerIconView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 14)
        textField.isHidden = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.text = "placeholder"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // stack view for icon and textfield stackview
    private let contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let sepratorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTextField))
        self.addGestureRecognizer(tapGesture)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTextField))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func didTapTextField() {
        placeHolderLabel.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.isActive = false
            }
        }
        textField.isHidden = false
        textField.becomeFirstResponder()
        sepratorView.backgroundColor = .appColor
        NSLayoutConstraint.activate([
            placeHolderLabel.heightAnchor.constraint(equalToConstant: textFieldStackView.bounds.height * 0.3),
        ])
        delegate?.textFieldDidBeginEditing(self)
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }
    
    private func setupUI() {
        containerIconView.addSubview(iconImageView)
        textFieldStackView.addArrangedSubview(placeHolderLabel)
        textFieldStackView.addArrangedSubview(textField)
        textField.isHidden = true
        textField.delegate = self
        contentStackView.addArrangedSubview(containerIconView)
        contentStackView.addArrangedSubview(textFieldStackView)
        
        containerStackView.addArrangedSubview(contentStackView)
        containerStackView.addArrangedSubview(sepratorView)
        
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
            containerIconView.widthAnchor.constraint(equalToConstant: self.bounds.height * 0.75),
            iconImageView.widthAnchor.constraint(equalTo:  containerIconView.widthAnchor, multiplier: 0.8),
            iconImageView.heightAnchor.constraint(equalTo:  containerIconView.widthAnchor, multiplier: 0.8),
            iconImageView.centerYAnchor.constraint(equalTo: containerIconView.centerYAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: containerIconView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textFieldStackView.heightAnchor.constraint(equalToConstant: self.bounds.height - 5)
        ])
        NSLayoutConstraint.activate([
            sepratorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
    }
    
    func configTextField(with placeholder: String,
                         iconName: String?) {
        self.placeHolderLabel.text = placeholder
        self.iconImageView.image = UIImage(named: iconName ?? "")
        if iconName == nil {
            containerIconView.isHidden = true
        }
    }
    
    func configTextField(with placeholder: String,
                         systemNameIcon: String?) {
        self.placeHolderLabel.text = placeholder
        self.iconImageView.image = UIImage(systemName: systemNameIcon ?? "")
        if systemNameIcon == nil {
            containerIconView.isHidden = true
        }
    }
    
    func setText(with text: String?) {
        self.containerIconView.isHidden = true
        self.placeHolderLabel.isHidden = true
        self.textField.text = text
    }
    
    func setTextFieldDisable() {
        placeHolderLabel.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.isActive = false
            }
        }
        self.sepratorView.backgroundColor = .black
        self.textField.resignFirstResponder()
        textField.isHidden = true
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }
}

extension TocTienWaterTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldDidEndEditing(textField)
        self.sepratorView.backgroundColor = .black
    }
}
