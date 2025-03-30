//
//  HomeViewModel.swift
//  TocTienWater
//
//  Created by Nhat on 3/9/25.
//

import Foundation
import Combine

protocol HomeViewModelProtocol {
    var dataSourcePublisher: AnyPublisher<DataState<[HomeSectionData]>, Never> { get }
    
    func fetchData()
    func refeshFileState()
    func getSectionData() -> [HomeSectionData]
}


final class HomeViewModel: HomeViewModelProtocol {
    
    let dataSourceSubject: CurrentValueSubject<DataState<[HomeSectionData]>, Never>
    private var cancellables = Set<AnyCancellable>()
    
    private let companyInfo = HomeInfoData(
        companyName: "CÔNG TY TNHH CẤP NƯỚC TÓC TIÊN",
        phoneNumber: "254 389 4894 - 086 537 9119",
        address: "Ấp 6, Xã Tóc Tiên, Thị xã Phú Mỹ\nBà Rịa - Vũng Tàu",
        mail: "office@toctienltd.vn"
    )
    
    init() {
        dataSourceSubject = CurrentValueSubject(.inittial)
    }
    
    var dataSourcePublisher: AnyPublisher<DataState<[HomeSectionData]>, Never> {
        dataSourceSubject.eraseToAnyPublisher()
    }
    
    func fetchData() {
        dataSourceSubject.send(.loading)
        //        NetworkService.shared.request(HomeAPIEndPoint.getImage(pageIndex: 0, limit: 100),
        //                                      responseType: FakeResponse.self)
        //        .sink { completion in
        //            switch completion {
        //            case .finished:
        //                print("Hoàn thành")
        //            case .failure(let error):
        //                print("Lỗi: \(error)")
        //            }
        //        } receiveValue: { response in
        //            // do something
        //            // reload UI in here
        //        }.store(in: &cancellables)
        
        let mockData = HomeSectionType.allCases.map { type in
            switch type {
            case .info:
                return HomeSectionData(
                    title: "Thông tin công ty",
                    type: .info,
                    items: [companyInfo]
                )
            case .category:
                return HomeSectionData(
                    title: "Các dịch vụ",
                    type: .category,
                    items: HomeCategory.allCases
                )
            case .fileState:
                return HomeSectionData(
                    title: "Trạng thái hồ sơ",
                    type: .fileState,
                    items: []
                )
            }
        }
        dataSourceSubject.send(.loaded(mockData))
    }
    
    func refeshFileState() {
        
    }
    
    func getSectionData() -> [HomeSectionData] {
        switch self.dataSourceSubject.value {
        case .loaded(let value):
            return value
        default:
            return []
        }
    }
    
}
