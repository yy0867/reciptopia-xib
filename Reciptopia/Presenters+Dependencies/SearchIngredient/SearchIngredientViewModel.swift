//
//  SearchIngredientViewModel.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation
import RxRelay

final class SearchIngredientViewModel {
    
    // MARK: - Properties
    let ingredients = BehaviorRelay<[Ingredient]>(value: [])
    let maxCount: Int = 10
    
    // MARK: - Methods
    func addIngredient(_ ingredientName: String) {
        guard ingredients.value.count < 10,
              !ingredientName.isEmpty else { return }
        
        ingredients.append(Ingredient(name: ingredientName))
    }
    
    func setIngredients(_ ingredients: [Ingredient]) {
        var mutableIngredients = ingredients
        if ingredients.count > maxCount {
            mutableIngredients = Array(ingredients[0..<maxCount])
        }
        self.ingredients.accept(mutableIngredients)
    }
    
    func toggleState(at index: Int) {
        guard 0 <= index && index < ingredients.value.count else { return }
        var mutableIngredients = ingredients.value
        let isMainIngredient = ingredients.value[index].isMainIngredient
        mutableIngredients[index].isMainIngredient = !isMainIngredient
        ingredients.accept(mutableIngredients)
    }
    
    func removeIngredient(at index: Int) {
        guard 0 <= index && index < ingredients.value.count else { return }
        ingredients.remove(at: index)
    }
}
