//
//  RealmSearchHistory.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation
import Realm
import RealmSwift

class RealmSearchHistory: Object, Identifiable {
    
    @Persisted(primaryKey: true)
    var id: Int = 0
    
    @Persisted
    var ingredients: List<RealmIngredient> = List<RealmIngredient>()
    
    @Persisted
    var timestamp: Date = Date()
    
    convenience init(ingredients: [Ingredient]) {
        self.init()
        let ingredientEntities = ingredients.map { $0.toEntity() }
        self.ingredients.removeAll()
        self.ingredients.append(objectsIn: ingredientEntities)
    }
}

extension SearchHistory {
    func toEntity() -> RealmSearchHistory {
        return RealmSearchHistory(ingredients: ingredients)
    }
}

extension RealmSearchHistory {
    func toModel() -> SearchHistory {
        let mappedIngredients = Array(ingredients.map { $0.toModel() })
        return SearchHistory(
            id: id,
            ingredients: mappedIngredients,
            timestamp: timestamp
        )
    }
}
