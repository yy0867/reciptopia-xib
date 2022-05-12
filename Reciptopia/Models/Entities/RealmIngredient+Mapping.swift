//
//  RealmIngredient.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation
import Realm
import RealmSwift

class RealmIngredient: Object {
    
    @Persisted
    var name: String = ""
    
    @Persisted
    var detail: String? = nil
    
    @Persisted
    var isMainIngredient: Bool = false
    
    convenience init(name: String, detail: String? = nil, isMainIngredient: Bool = false) {
        self.name = name
        self.detail = detail
        self.isMainIngredient = isMainIngredient
    }
}

extension Ingredient {
    func toEntity() -> RealmIngredient {
        return RealmIngredient(
            name: name,
            detail: detail,
            isMainIngredient: isMainIngredient
        )
    }
}

extension RealmIngredient {
    func toModel() -> Ingredient {
        return Ingredient(
            id: nil,
            name: name,
            detail: detail,
            isMainIngredient: isMainIngredient
        )
    }
}
