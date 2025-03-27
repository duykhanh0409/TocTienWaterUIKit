//
//  IntroduceViewModel.swift
//  TocTienWater
//
//  Created by Nhat on 3/21/25.
//

import Foundation
import Combine

protocol IntroduceViewModelProtocol {
    var dataSourcePublisher: AnyPublisher<DataState<[IntroduceType]>, Never> { get }
    
    func getData() -> [IntroduceType]
}

final class IntroduceViewModel: IntroduceViewModelProtocol {
    let dataSourceSubject: CurrentValueSubject<DataState<[IntroduceType]>, Never>
    var dataSourcePublisher: AnyPublisher<DataState<[IntroduceType]>, Never> {
        dataSourceSubject.eraseToAnyPublisher()
    }
    
    init () {
        dataSourceSubject = .init(.loaded(IntroduceType.allCases))
    }
    
    func getData() -> [IntroduceType] {
        switch self.dataSourceSubject.value {
        case .loaded(let value):
            return value
        default:
            return []
        }
    }
}
