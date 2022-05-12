//
//  SearchHistory.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation

struct SearchHistory {
    let id: Int?
    let ingredients: [Ingredient]
    let timestamp: Date
    
    init(id: Int? = nil, ingredients: [Ingredient], timestamp: Date = Date()) {
        self.id = id
        self.ingredients = ingredients
        self.timestamp = timestamp
    }
}

extension SearchHistory: Identifiable, Equatable {}
