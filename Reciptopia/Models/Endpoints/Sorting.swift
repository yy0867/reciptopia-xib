//
//  Sorting.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/23.
//

import Foundation

struct Sorting {
    
    enum Property: String, CaseIterable {
        case id
        case name
    }
    
    enum Order: String, CaseIterable {
        case ascending = "ASC"
        case descending = "DESC"
    }
    
    // MARK: - Properties
    let property: Property
    let order: Order
    
    // MARK: - Methods
    init(property: Property = .id, order: Order = .ascending) {
        self.property = property
        self.order = order
    }
    
    func asQuery() -> [URLQueryItem] {
        return [
            URLQueryItem(name: property.rawValue, value: order.rawValue),
        ]
    }
}
