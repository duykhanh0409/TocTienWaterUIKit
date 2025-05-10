//
//  RegisterTextFieldCell.swift
//  TocTienWater
//
//  Created by Tuan Bui on 14/3/25.
//

import UIKit

protocol RegisterTextFieldCellDelegate: AnyObject {
    func endEditing(text: String, inputType: InputType?)
}

class RegisterTextFieldCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: TocTienWaterTextField!
    weak var delegate: RegisterTextFieldCellDelegate?
    var inputType: InputType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        textField.delegate = self
    }
    
    override func prepareForReuse() {
        self.textField.setText(with: "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(with inputType: InputType, registerData: RegistrationData) {
        titleLabel.text = inputType.title
        titleLabel.font = .systemFont(ofSize: 14)
        self.inputType = inputType
        switch inputType {
        case .fullName:
            self.textField.setText(with: registerData.fullName)
        case .installationAddress:
            self.textField.setText(with: registerData.installationAddress)
        case .phoneNumber:
            self.textField.setText(with: registerData.phoneNumber)
        case .email:
            self.textField.setText(with: registerData.email)
        case .representativeName:
            self.textField.setText(with: registerData.representativeName)
        case .contactAddress:
            self.textField.setText(with: registerData.contactAddress)
        }
    }
}

extension RegisterTextFieldCell: TocTienWaterTextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            delegate?.endEditing(text: text, inputType: inputType)
        }
    }
}
