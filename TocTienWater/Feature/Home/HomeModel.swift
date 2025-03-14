//
//  HomeModel.swift
//  TocTienWater
//
//  Created by Nhat on 3/11/25.
//

import Foundation

enum HomeSectionType: Int, CaseIterable {
    case info = 0
    case category
    case fileState
}

struct HomeSectionData {
    let title: String
    let type: HomeSectionType
    let items: [Any]
}

struct HomeInfoData {
    let companyName: String
    let phoneNumber: String
    let address: String
    let mail: String
}

enum HomeCategory: String, CaseIterable {
    case bills = "Hóa đơn"
    case stats = "Đăng ký lắp đặt"
    case settings = "Bảng giá nước"
    case intro = "Giới thiệu"
    
    var iconName: String {
        switch self {
        case .bills:
            return "list.bullet.clipboard"
        case .stats:
            return "square.and.pencil"
        case .settings:
            return "tag.square"
        case .intro:
            return "building.2.fill"
        }
    }
}

struct FileStateItem {
    let id: String
    let name: String
    let status: String
    let date: String
}
