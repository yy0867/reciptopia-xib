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
    
    init(id: Int? = nil, ingredients: [Ingredient]) {
        self.id = id
        self.ingredients = ingredients
    }
}

extension SearchHistory: Equatable {}
