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
    @IBOutlet weak var textField: UITextField!
    weak var delegate: RegisterTextFieldCellDelegate?
    var inputType: InputType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        textField.delegate = self
    }
    
    override func prepareForReuse() {
        self.textField.text = ""
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
            self.textField.text = registerData.fullName
        case .installationAddress:
            self.textField.text = registerData.installationAddress
        case .phoneNumber:
            self.textField.text = registerData.phoneNumber
        case .email:
            self.textField.text = registerData.email
        case .representativeName:
            self.textField.text = registerData.representativeName
        case .contactAddress:
            self.textField.text = registerData.contactAddress
        }
    }
}

extension RegisterTextFieldCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            delegate?.endEditing(text: text, inputType: inputType)
        }
    }
}
