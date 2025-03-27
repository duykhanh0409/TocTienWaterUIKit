//
//  UIButton+Ext.swift
//  TocTienWater
//
//  Created by Tuan Bui on 18/3/25.
//

import ObjectiveC
import UIKit

private var associatedKey: UInt8 = 0

extension UIButton {
    func setAssociatedObject<T>(_ value: T?) {
        objc_setAssociatedObject(self, &associatedKey, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func getAssociatedObject<T>() -> T? {
        return objc_getAssociatedObject(self, &associatedKey) as? T
    }
}
