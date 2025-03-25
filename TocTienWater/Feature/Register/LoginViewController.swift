//
//  RegisterViewController.swift
//  TocTienWater
//
//  Created by Nhat on 3/15/25.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: TocTienButton!
    @IBOutlet weak var customerPhoneTextField: TocTienWaterTextField!
    @IBOutlet weak var customerCodeTextField: TocTienWaterTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapLogiView))
        self.view.addGestureRecognizer(tapGesture)
        self.view.isUserInteractionEnabled = true
        
        customerCodeTextField.configTextField(with: "Mã Khách Hàng",
                                              iconName: "chevron-left-right")
        customerCodeTextField.delegate = self
        
        customerPhoneTextField.configTextField(with: "Số điện thoại",
                                               iconName: "icon-phone")
        customerPhoneTextField.delegate = self
        setupButtons()
    }
    
    private func setupButtons() {
        loginButton.cornerRadius = 16
        loginButton.typeOfButton = .primary
        loginButton.tintColor = .white
        loginButton.setTitle("Đăng Nhập", for: .normal)
        
        registerButton.tintColor = .appColor
        registerButton.setTitle("Đăng ký", for: .normal)
        
        backButton.tintColor = .appColor
        backButton.setTitle("Quay lại", for: .normal)
    }
    
    @objc
    private func onTapLogiView() {
        customerCodeTextField.setTextFieldDisable()
        customerPhoneTextField.setTextFieldDisable()
    }
    
    
    @IBAction func didTapLogin(_ sender: Any) {
        // TODO: need API
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        // TODO: Need Register Screen
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension LoginViewController: TocTienWaterTextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: TocTienWaterTextField) {
        if textField == customerPhoneTextField {
            customerCodeTextField.setTextFieldDisable()
        } else if textField == customerCodeTextField {
            customerPhoneTextField.setTextFieldDisable()
        }
    }
}
