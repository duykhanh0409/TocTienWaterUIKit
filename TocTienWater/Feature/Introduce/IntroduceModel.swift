//
//  IntroduceModel.swift
//  TocTienWater
//
//  Created by Nhat on 3/25/25.
//

import Foundation

enum IntroduceType: CaseIterable {
    case address
    case ceoName
    case ceoPhoneNumber
    case bankAccountNumber
    case hotline
    case telePhone
    case tablePhone
    case email
    case website
    
    var title: String {
        switch self {
        case .address:
            return "Ấp 6, xã Tóc Tiên, Thị xã Phú Mỹ, Bà Rịa - Vũng Tàu"
        case .ceoName:
            return "Phan Thanh Hải"
        case .ceoPhoneNumber:
            return "350 081 5711"
        case .bankAccountNumber:
            return "Số tài khoản: 0 0810 0012 7995, Ngân hàng VIETCOMBANK BR-VT PGD số 3"
        case .hotline:
            return "0254 389 4894 - 086 537 9119"
        case .telePhone:
            return "0254 3 894 894"
        case .tablePhone:
            return "086 537 9119"
        case .email:
            return "toctienltd@gmail.com"
        case .website:
            return "toctienltd.vn"
        }
    }
    
    var iconName: String {
        switch self {
        case .address:
            return "building.2"
        case .ceoName:
           return  "person.2.fill"
        case .ceoPhoneNumber:
            return "building.columns.fill"
        case .bankAccountNumber:
            return "wallet.pass.fill"
        case .hotline:
            return "phone.arrow.up.right"
        case .telePhone:
            return "phone.fill"
        case .tablePhone:
            return "teletype"
        case .email:
            return "envelope.fill"
        case .website:
            return "safari.fill"
        }
    }
    
    var actionIconName: String {
        switch self {
        case .address:
            return "map.fill"
        case .hotline:
            return "phone.arrow.up.right"
        case .email:
            return "paperplane.fill"
        case .website:
            return "safari.fill"
        default:
            return ""
        }
    }
}
