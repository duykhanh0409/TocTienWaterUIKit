//
//  ImageCollectionViewCell.swift
//  TocTienWater
//
//  Created by Tuan Bui Minh (SDC11) on 19/3/25.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configCell(image: UIImage) {
        self.image.image = image
    }
}
