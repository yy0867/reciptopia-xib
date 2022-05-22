//
//  PostDTOTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/23.
//

import XCTest
@testable import Reciptopia

class PostDTOTests: XCTestCase {

    func test_PostDTOSearch_asQuery_shouldReturnExpectedQuery() {
        // Given
        let ingredients = generateRandomIngredients()
        let mainIngredients = ingredients.filter { $0.isMainIngredient }
        let subIngredients = ingredients.filter { !$0.isMainIngredient }
        
        let expectedSortingProperty = Sorting.Property.allCases.randomElement()!
        let expectedSortingOrder = Sorting.Order.allCases.randomElement()!
        let sorting = Sorting(property: expectedSortingProperty, order: expectedSortingOrder)
        
        let expectedPage = Int.random(in: 1...20)
        let expectedSize = Int.random(in: 1...20)
        let paging = Paging(page: expectedPage, size: expectedSize)
        
        let dto = PostDTO.Search(ingredients: ingredients, sorting: sorting, paging: paging)
        
        // When
        let query = dto.asQuery()
        
        // Then
        XCTAssertTrue(query.contains(
            URLQueryItem(
                name: "mainIngredients",
                value: mainIngredients.map { $0.name }.joined(separator: ",")
            )
        ))
        
        XCTAssertTrue(query.contains(
            URLQueryItem(
                name: "subIngredients",
                value: subIngredients.map { $0.name }.joined(separator: ",")
            )
        ))
        
        XCTAssertTrue(query.contains(
            URLQueryItem(name: "page", value: "\(expectedPage)")
        ))
        
        XCTAssertTrue(query.contains(
            URLQueryItem(name: "size", value: "\(expectedSize)")
        ))
        
        XCTAssertTrue(query.contains(
            URLQueryItem(
                name: "sort",
                value: "\(expectedSortingProperty.rawValue),\(expectedSortingOrder.rawValue)"
            )
        ))
    }
    
    private func generateRandomIngredients(_ length: Int = 10) -> [Ingredient] {
        var ingredients = [Ingredient]()
        for i in 1...length {
            ingredients.append(
                Ingredient(name: generateRandomString())
            )
        }
        return ingredients
    }
}
