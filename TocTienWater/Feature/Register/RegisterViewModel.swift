//
//  RegisterViewModel.swift
//  TocTienWater
//
//  Created by Tuan Bui on 14/3/25.
//

import Foundation
import Combine
import UIKit

protocol RegisterViewModelProtocol {
    var dataSourcePublisher: AnyPublisher<DataState<[FormField]>, Never> { get }
    
    func fetchData()
    func refeshFileState()
    func getDataCell() -> [FormField]
    func setFullName(fullName: String)
    func setInstallationAddress(installationAddress: String)
    func setPhoneNumber(phoneNumber: String)
    func setEmail(email: String)
    func setRepresentativeName(representativeName: String)
    func setContactAddress(contactAddress: String)
    func setCustomerType(customerType: CustomerType)
    func insertImageSelected(type: UploadImageType, image: UIImage)
    func setWaterUsagePurpose(waterUsagePurpose: WaterUsagePurpose)
    func getRegistrationData() -> RegistrationData
    func getImages(type: UploadImageType) -> [UIImage]?
}


final class RegisterViewModel: RegisterViewModelProtocol {
    let dataSourceSubject: CurrentValueSubject<DataState<[FormField]>, Never>
    private var cancellables = Set<AnyCancellable>()
    let registrationData: RegistrationData?
    
    init() {
        dataSourceSubject = CurrentValueSubject(.inittial)
        registrationData = RegistrationData()
    }
    
    var dataSourcePublisher: AnyPublisher<DataState<[FormField]>, Never> {
        dataSourceSubject.eraseToAnyPublisher()
    }
    
    func fetchData() {
        dataSourceSubject.send(.loading)
        let formFields: [FormField] = [
            FormField(type: .textField(InputType.fullName)),
            FormField(type: .textField(InputType.installationAddress)),
            FormField(type: .textField(InputType.phoneNumber)),
            FormField(type: .textField(InputType.email)),
            FormField(type: .textField(InputType.representativeName)),
            FormField(type: .textField(InputType.contactAddress)),
            FormField(type: .customerType("Đối tượng khách hàng", [CustomerType.business,
                                                                   CustomerType.individual])),
            FormField(type: .waterUsagePurpose("Mục đích sử dụng nước", [WaterUsagePurpose.domestic,
                                                                         WaterUsagePurpose.production,
                                                                         WaterUsagePurpose.business,
                                                                         WaterUsagePurpose.administration])),
            FormField(type: .imageUpload(UploadImageType.waterMeterApplication)),
            FormField(type: .imageUpload(UploadImageType.landUseCertificate)),
            FormField(type: .imageUpload(UploadImageType.businessLicense)),
            FormField(type: .imageUpload(UploadImageType.identityDocument)),
            FormField(type: .bottom)
        ]
        dataSourceSubject.send(.loaded(formFields))
    }
    
    func refeshFileState() {
        
    }
    
    func getDataCell() -> [FormField] {
        switch self.dataSourceSubject.value {
        case .loaded(let value):
            return value
        default:
            return []
        }
    }
    
    func setFullName(fullName: String) {
        registrationData?.fullName = fullName
    }
    
    func setInstallationAddress(installationAddress: String) {
        registrationData?.installationAddress = installationAddress
    }
    
    func setPhoneNumber(phoneNumber: String) {
        registrationData?.phoneNumber = phoneNumber
    }
    
    func setEmail(email: String) {
        registrationData?.email = email
    }
    
    func setRepresentativeName(representativeName: String) {
        registrationData?.representativeName = representativeName
    }
    
    func setContactAddress(contactAddress: String) {
        registrationData?.contactAddress = contactAddress
    }
    
    func setCustomerType(customerType: CustomerType) {
        registrationData?.customerType = customerType
    }
    
    func setWaterUsagePurpose(waterUsagePurpose: WaterUsagePurpose) {
        registrationData?.waterUsagePurpose = waterUsagePurpose
    }
    
    func insertImageSelected(type: UploadImageType, image: UIImage) {
        switch type {
        case .waterMeterApplication:
            registrationData?.waterMeterApplication?.append(image)
        case .landUseCertificate:
            registrationData?.landUseCertificate?.append(image)
        case .businessLicense:
            registrationData?.businessLicense?.append(image)
        case .identityDocument:
            registrationData?.identityDocument?.append(image)
        }
    }
    
    func getRegistrationData() -> RegistrationData {
        return registrationData ?? .init()
    }
    
    func getImages(type: UploadImageType) -> [UIImage]? {
        switch type {
        case .waterMeterApplication:
            registrationData?.waterMeterApplication
        case .landUseCertificate:
            registrationData?.landUseCertificate
        case .businessLicense:
            registrationData?.businessLicense
        case .identityDocument:
            registrationData?.identityDocument
        }
    }
}

