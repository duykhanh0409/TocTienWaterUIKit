//
//  SelectImageCell.swift
//  TocTienWater
//
//  Created by Tuan Bui Minh (SDC11) on 19/3/25.
//

import UIKit

protocol SelectImageCellDelegate: AnyObject {
    func selectImage()
}

class SelectImageCell: UICollectionViewCell {

    weak var delegate: SelectImageCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func selectImage(_ sender: Any) {
        delegate?.selectImage()
    }
}
