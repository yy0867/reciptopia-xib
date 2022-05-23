//
//  PostDTO.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/23.
//

import Foundation

struct PostDTO {
    
    struct Search {
        let mainIngredients: [Ingredient]
        let subIngredients: [Ingredient]
        let sorting: Sorting
        let paging: Paging
        
        init(ingredients: [Ingredient], sorting: Sorting = .init(), paging: Paging) {
            self.mainIngredients = ingredients.filter { $0.isMainIngredient }
            self.subIngredients = ingredients.filter { !$0.isMainIngredient }
            self.sorting = sorting
            self.paging = paging
        }
    }
}

extension PostDTO.Search {
    
    func asQuery() -> [URLQueryItem] {
        let mainIngredientQuery = URLQueryItem(
            name: "mainIngredients",
            value: convertIngredientsToQueryValue(mainIngredients)
        )
        let subIngredientQuery = URLQueryItem(
            name: "subIngredients",
            value: convertIngredientsToQueryValue(subIngredients)
        )
        
        return [mainIngredientQuery, subIngredientQuery] + sorting.asQuery() + paging.asQuery()
    }
    
    private func convertIngredientsToQueryValue(_ ingredients: [Ingredient]) -> String {
        return ingredients
            .map { $0.name }
            .joined(separator: ",")
    }
}
