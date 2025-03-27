//
//  RegisterImageCell.swift
//  TocTienWater
//
//  Created by Tuan Bui on 18/3/25.
//

import UIKit

protocol RegisterImageCellDelegate: AnyObject {
    func chooseImage(type: UploadImageType?)
}

class RegisterImageCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    private var type: UploadImageType?
    weak var delegate: RegisterImageCellDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images: [UIImage?] = [] {
        didSet {
            images.append(nil)
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.registerCellWithNib(SelectImageCell.self)
        collectionView.registerCellWithNib(ImageCollectionViewCell.self)
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(type: UploadImageType, images: [UIImage]?) {
        titleLabel.text = type.title
        titleLabel.font = .systemFont(ofSize: 14)
        self.type = type
        self.images = []
        if let images = images, images.count > 0 {
            self.images = images
        }
    }
    
}

// MARK: - UICollectionViewDelegate
extension RegisterImageCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == images.count - 1 {
            let cell = collectionView.dequeueCell(SelectImageCell.self, for: indexPath)
            cell.delegate = self
            return cell
        }
        let cell = collectionView.dequeueCell(ImageCollectionViewCell.self, for: indexPath)
        if let image = images[indexPath.row] {
            cell.configCell(image: image)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == images.count - 1 && images.count == 1 {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        let width = collectionView.frame.width
        let spacing: CGFloat = 10
        let itemWidth = (width - spacing * 2) / 3
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

// MARK: - SelectImageCellDelegate
extension RegisterImageCell: SelectImageCellDelegate {
    func selectImage() {
        delegate?.chooseImage(type: type)
    }
}
