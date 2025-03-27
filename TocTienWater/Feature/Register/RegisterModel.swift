//
//  RegisterModel.swift
//  TocTienWater
//
//  Created by Tuan Bui on 14/3/25.
//

import Foundation
import UIKit

enum CustomerType: Int, CaseIterable {
    case business
    case individual
    
    var title: String {
        switch self {
        case .business:
            return "Doanh nghiệp"
        case .individual:
            return "Hộ dân"
        }
    }
}

enum InputType: Int, CaseIterable {
    case fullName
    case installationAddress
    case phoneNumber
    case email
    case representativeName
    case contactAddress
    
    var title: String {
        switch self {
        case .fullName:
            return "Họ và tên"
        case .installationAddress:
            return "Địa chỉ lắp đặt đồng hồ"
        case .phoneNumber:
            return "Số điện thoại"
        case .email:
            return "Email"
        case .representativeName:
            return "Họ và tên người đứng tên"
        case .contactAddress:
            return "Địa chỉ liên hệ"
        }
    }
}


enum WaterUsagePurpose: String, CaseIterable {
    case domestic
    case production
    case business
    case administration
    
    var title: String {
        switch self {
        case .domestic:
            return "Sinh hoạt"
        case .production:
            return "Sản xuất"
        case .business:
            return "Kinh doanh"
        case .administration:
            return "Hành chính sự nghiệp"
        }
    }
}

enum UploadImageType: String, CaseIterable {
    case waterMeterApplication
    case landUseCertificate
    case businessLicense
    case identityDocument
    
    var title: String {
        switch self {
        case .waterMeterApplication:
            return "Giấy đề nghị lắp đặt đồng hồ nước"
        case .landUseCertificate:
            return "Bản sao công chứng Quyền sử dụng đất hoặc Hợp đồng thuê trụ sở"
        case .businessLicense:
            return "Giấy phép đăng ký kinh doanh bản sao công chứng còn hiệu lực trong vòng 6 tháng."
        case .identityDocument:
            return "CMND / Căn cước / Hộ chiếu của chủ Doanh nghiệp"
        }
    }
}

enum FormFieldType {
    case textField(_ textField: InputType)
    case customerType(_ label: String, _ options: [CustomerType])
    case waterUsagePurpose(_ label: String, _ options: [WaterUsagePurpose])
    case imageUpload(_ type: UploadImageType)
    case bottom
}

struct FormField {
    var type: FormFieldType
}

class RegistrationData {
    var fullName: String?
    var installationAddress: String?
    var phoneNumber: String?
    var email: String?
    var representativeName: String?
    var contactAddress: String?
    var customerType: CustomerType?
    var waterUsagePurpose: WaterUsagePurpose?
    var waterMeterApplication: [UIImage]?
    var landUseCertificate: [UIImage]?
    var businessLicense: [UIImage]?
    var identityDocument: [UIImage]?
    
    init() {
        waterMeterApplication = []
        landUseCertificate = []
        businessLicense = []
        identityDocument = []
    }
}
