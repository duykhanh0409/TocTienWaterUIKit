//
//  RegisterBottomCell.swift
//  TocTienWater
//
//  Created by Tuan Bui on 18/3/25.
//

import UIKit

protocol RegisterBottomCellDelegate: AnyObject {
    func register()
    func backRoot()
}

class RegisterBottomCell: UITableViewCell {

    weak var delegate: RegisterBottomCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func register(_ sender: Any) {
        delegate?.register()
    }
    
    @IBAction func backAction(_ sender: Any) {
        delegate?.backRoot()
    }
    
}
