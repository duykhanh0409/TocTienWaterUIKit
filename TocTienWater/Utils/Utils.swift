//
//  Utils.swift
//  TocTienWater
//
//  Created by Nhat on 3/10/25.
//

import UIKit
final class Utils {
    
    static public let shared = Utils()
    private init() {}
    
    
    var safeAreaInsets: UIEdgeInsets? {
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            return scene?.windows.first?.safeAreaInsets
    }
    
    var keyWindown: UIWindow? {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return scene?.windows.first
    }
}
