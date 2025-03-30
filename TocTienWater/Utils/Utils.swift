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
    
    func openURL(with type: IntroduceType) {
        switch type {
        case .address:
            let latitude:Double = 10.605633434466945
            let longitude:Double = 107.07720501627898
            let googleMapsURLString = "https://www.google.com/maps/place/C%C3%B4ng+Ty+Tnhh+C%E1%BA%A5p+N%C6%B0%E1%BB%9Bc+T%C3%B3c+Ti%C3%AAn/@16.8092866,102.2496325,6z/data=!4m6!3m5!1s0x3175119dad03d777:0x379abaaec6e6152b!8m2!3d10.605528!4d107.0771621!16s%2Fg%2F11whx15t3t?entry=ttu&g_ep=EgoyMDI1MDMyNC4wIKXMDSoASAFQAw%3D%3D"
            
            let googleMapsURL = URL(string: googleMapsURLString)!
            let appleMapsURL = URL(string: "http://maps.apple.com/?ll=\(latitude),\(longitude)")!
            
            if UIApplication.shared.canOpenURL(googleMapsURL) {
                UIApplication.shared.open(googleMapsURL, options: [:]) { success in
                    if !success {
                        print("Không thể mở Google Maps")
                    }
                }
            } else {
                UIApplication.shared.open(appleMapsURL, options: [:]) { success in
                    if !success {
                        print("Không thể mở Apple Maps")
                    }
                }
            }
        case .hotline:
            if let url = URL(string: "tel://\(0865379119)") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    print("Không thể mở ứng dụng Điện thoại.")
                }
            } else {
                print("Số điện thoại không hợp lệ.")
            }
        case .email:
            let email = "toctienltd@gmail.com"
            if let url = URL(string: "mailto:\(email)") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:]) { success in
                        if !success {
                            print("Không thể mở ứng dụng email mặc định.")
                        }
                    }
                } else {
                    print("Không có ứng dụng email nào khả dụng.")
                }
            }
        case .website:
            let websiteString = "https://toctienltd.vn"
            if let url = URL(string: websiteString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:]) { success in
                        if !success {
                            print("Không thể mở website.")
                        }
                    }
                } else {
                    print("URL website không hợp lệ.")
                }
            }
        default:
            break
        }
    }
    
    
    func formatNumber<T: Numeric>(_ value: T) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 0
        
        if let doubleValue = value as? Double {
            return formatter.string(from: NSNumber(value: doubleValue)) ?? "\(value)"
        } else if let floatValue = value as? Float {
            return formatter.string(from: NSNumber(value: floatValue)) ?? "\(value)"
        } else if let intValue = value as? Int {
            return formatter.string(from: NSNumber(value: intValue)) ?? "\(value)"
        } else {
            return "\(value)"
        }
    }
}
