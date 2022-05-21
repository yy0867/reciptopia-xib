//
//  RealmSearchHistory.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation
import Realm
import RealmSwift

class RealmSearchHistory: Object, RealmIdentifiable {
    
    @Persisted(primaryKey: true)
    var id: Int = 0
    
    @Persisted
    var ingredients: List<RealmIngredient> = List<RealmIngredient>()
    
    @Persisted
    var timestamp: Date = Date()
    
    convenience init(id: Int, ingredients: [Ingredient], timestamp: Date) {
        self.init()
        self.id = id
        self.timestamp = timestamp
        let ingredientEntities = ingredients.map { $0.toEntity() }
        self.ingredients.removeAll()
        self.ingredients.append(objectsIn: ingredientEntities)
    }
}

extension SearchHistory {
    func toEntity() -> RealmSearchHistory {
        return RealmSearchHistory(
            id: id ?? 0,
            ingredients: ingredients,
            timestamp: timestamp
        )
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
