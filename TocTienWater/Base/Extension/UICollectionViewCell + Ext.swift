//
//  UICollectionViewCell + Ext.swift
//  TocTienWater
//
//  Created by Nhat on 3/12/25.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let identifier = String(describing: cellClass)
        register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    func registerCellWithNib<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let identifier = String(describing: cellClass)
        register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: cellClass)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue cell with identifier: \(identifier)")
        }
        return cell
    }
}
