//
//  WaterPriceViewModel.swift
//  TocTienWater
//
//  Created by Bui Tuan on 31/3/25.
//

import Combine
import UIKit

protocol WaterPriceViewModelProtocol {
    var dataSourcePublisher: AnyPublisher<DataState<[WaterPriceCategory]>, Never> { get }
    
    func fetchData()
    func refeshFileState()
    func getDataCell() -> [WaterPriceCategory]
}

final class WaterPriceViewModel: WaterPriceViewModelProtocol {
    
    let dataSourceSubject: CurrentValueSubject<DataState<[WaterPriceCategory]>, Never>
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        dataSourceSubject = CurrentValueSubject(.inittial)
    }
    
    var dataSourcePublisher: AnyPublisher<DataState<[WaterPriceCategory]>, Never> {
        dataSourceSubject.eraseToAnyPublisher()
    }
    
    func fetchData() {
        dataSourceSubject.send(.loading)
        let waterPrices: [WaterPriceCategory] = [
            WaterPriceCategory(
                title: "Nước sinh hoạt đồng bào dân tộc",
                options: [
                    WaterPriceOption(description: "Từ 0 – 10m³ đồng hồ/tháng", price: "5.500"),
                    WaterPriceOption(description: "Từ trên 10 – 20 m³ đồng hồ/tháng", price: "11.000"),
                    WaterPriceOption(description: "Từ trên 20 m³ đồng hồ/tháng", price: "12.000")
                ]
            ),
            WaterPriceCategory(
                title: "Nước sinh hoạt nông thôn",
                options: [
                    WaterPriceOption(description: "Từ 0 – 10m³ đồng hồ/tháng", price: "9.300"),
                    WaterPriceOption(description: "Từ trên 10 – 20 m³ đồng hồ/tháng", price: "11.000"),
                    WaterPriceOption(description: "Từ trên 20 m³ đồng hồ/tháng", price: "12.500")
                ]
            ),
            WaterPriceCategory(
                title: "Nước sinh hoạt đô thị",
                options: [
                    WaterPriceOption(description: "Từ 0 – 10m³ đồng hồ/tháng", price: "9.400"),
                    WaterPriceOption(description: "Từ trên 10 – 20 m³ đồng hồ/tháng", price: "12.600"),
                    WaterPriceOption(description: "Từ trên 20 m³ đồng hồ/tháng", price: "13.500")
                ]
            ),
            WaterPriceCategory(
                title: "Hành chính sự nghiệp",
                options: [
                    WaterPriceOption(description: "", price: "13.100")
                ]
            ),
            WaterPriceCategory(
                title: "Sản xuất vật chất",
                options: [
                    WaterPriceOption(description: "Bán trực tiếp cho khách hàng", price: "13.400"),
                    WaterPriceOption(description: "Bán qua đồng hồ trong Khu công nghiệp", price: "13.200")
                ]
            ),
            WaterPriceCategory(
                title: "Kinh doanh dịch vụ",
                options: [
                    WaterPriceOption(description: "", price: "20.200")
                ]
            )
        ]
        dataSourceSubject.send(.loaded(waterPrices))
    }
    
    func refeshFileState() {
        
    }
    
    func getDataCell() -> [WaterPriceCategory] {
        switch self.dataSourceSubject.value {
        case .loaded(let value):
            return value
        default:
            return []
        }
    }
}
