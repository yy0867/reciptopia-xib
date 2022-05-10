//
//  CheckIngredientViewModel.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/10.
//

import Foundation
import RxRelay

final class CheckIngredientViewModel {
    
    // MARK: - Properties
    let ingredients = BehaviorRelay<[Ingredient]>(value: [])
    let maxCount = 10
    
    // MARK: - Methods
    init(ingredientNames: [String]) {
        func mapIngredientNamesToIngredients(_ ingredientNames: [String]) -> [Ingredient] {
            return ingredientNames.map { Ingredient(name: $0) }
        }
        let ingredients = mapIngredientNamesToIngredients(ingredientNames)
        
        self.ingredients.accept(ingredients)
    }
    
    func addIngredient(_ ingredientName: String) {
        guard ingredients.value.count < 10 else { return }
        
        ingredients.append(Ingredient(name: ingredientName))
    }
    
    func removeIngredient(at index: Int) {
        guard 0 <= index && index < ingredients.value.count else { return }
        ingredients.remove(at: index)
    }
    
    func changeState(to isMainIngredient: Bool, at index: Int) {
        guard 0 <= index && index < ingredients.value.count else { return }
        var mutableIngredients = ingredients.value
        mutableIngredients[index].isMainIngredient = isMainIngredient
        ingredients.accept(mutableIngredients)
    }
}