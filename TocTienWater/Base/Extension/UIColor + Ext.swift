//
//  UIColor + Ext.swift
//  TocTienWater
//
//  Created by Nhat on 3/10/25.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(red: Double(red) / 255.0,
                      green: Double(green) / 255.0,
                      blue: Double(blue) / 255.0,
                  alpha: Double(alpha))
    }
    
    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(red: Double((rgb >> 16) & 0xFF) / 255.0,
                  green: Double((rgb >> 8) & 0xFF) / 255.0,
                  blue: Double(rgb & 0xFF) / 255.0,
                  alpha: alpha)
    }
    
    convenience init?(hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        let red, green, blue, alpha: CGFloat
        switch chars.count {
        case 3:
            chars = chars.flatMap({ [$0, $0] })
            fallthrough
        case 6:
            chars = ["F", "F"] + chars
            fallthrough
        case 8:
            alpha = Double(strtoul(String(chars[0...1]), nil, 16)) / 255
            red = Double(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = Double(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue = Double(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            return nil
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // Color using hexColor
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var mHexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        mHexString = mHexString.replacingOccurrences(of: "#",
                                                     with: "",
                                                     options: NSString.CompareOptions.literal,
                                                     range: nil).uppercased()
        
        if mHexString.count < 6 {
            // set for default color
            mHexString = "#1D89DA"
        }
        
        if mHexString.hasPrefix("#") {
            mHexString = String(mHexString.dropFirst())
        }
        
        if mHexString.count == 6 {
            var rgbValue: UInt64 = 0
            Scanner(string: mHexString).scanHexInt64(&rgbValue)
            self.init(red: Double((rgbValue & 0xFF0000) >> 16) / 255,
                      green: Double((rgbValue & 0x00FF00) >> 8) / 255,
                      blue: Double((rgbValue & 0x0000FF)) / 255,
                      alpha: alpha)
        } else {
            var rgbValue: UInt64 = 0
            Scanner(string: mHexString).scanHexInt64(&rgbValue)
            self.init(red: Double((rgbValue & 0xFF000000) >> 24) / 255,
                      green: Double((rgbValue & 0x00FF00) >> 16) / 255,
                      blue: Double((rgbValue & 0xFF00) >> 8) / 255,
                      alpha: Double(rgbValue & 0x0FF) / 255)
        }
    }
}

extension UIColor {
    static let appColor: UIColor = .init(hexString: "#33767d")
}
