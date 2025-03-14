//
//  DataState.swift
//  TocTienWater
//
//  Created by Nhat on 3/11/25.
//

import Foundation

enum DataState<T> {
    case inittial
    case loading
    case loaded(T)
    case error(Error)
}
