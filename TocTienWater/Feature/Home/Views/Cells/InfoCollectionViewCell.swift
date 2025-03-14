//
//  InfoCollectionViewCell.swift
//  TocTienWater
//
//  Created by Nhat on 3/10/25.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var headerTitleLabel: UILabel!
    @IBOutlet private weak var logoImage: UIImageView!
    @IBOutlet private weak var addressIcon: UIImageView!
    @IBOutlet private weak var mapButton: UIButton!
    @IBOutlet private weak var phoneIcon: UIImageView!
    @IBOutlet private weak var phoneButton: UIView!
    @IBOutlet private weak var mailIcon: UIImageView!
    @IBOutlet private weak var sendMailButton: UIButton!
    @IBOutlet private weak var mailLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        // TODO: move to constant
        headerTitleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        headerTitleLabel.textColor = .appColor
        
        addressIcon.tintColor = .appColor
        mapButton.tintColor = .appColor
        phoneIcon.tintColor = .appColor
        phoneButton.tintColor = .appColor
        mailIcon.tintColor = .appColor
        sendMailButton.tintColor = .appColor
        
        self.containerView.layer.cornerRadius = 8
        self.containerView.clipsToBounds = true
        self.containerView.backgroundColor = UIColor(hexString: "#EDF2F2")
    }
    
    func configCell(with data: HomeInfoData) {
        headerTitleLabel.text = data.companyName
        addressLabel.text = data.address
        phoneLabel.text = data.phoneNumber
        mailLabel.text = data.mail
    }
}
