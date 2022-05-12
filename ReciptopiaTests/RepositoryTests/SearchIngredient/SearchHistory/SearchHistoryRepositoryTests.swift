//
//  SearchHistoryRepositoryTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/12.
//

import XCTest
import RxSwift
import RxBlocking
import RxTest
@testable import Reciptopia

class SearchHistoryRepositoryTests: XCTestCase {

    var repository: SearchHistoryRepositoryProtocol!
    
    override func setUp() {
        dev.searchHistoryDataStore.searchHistories = []
        self.repository = SearchHistoryRepository(dataStore: dev.searchHistoryDataStore)
    }
    
    func test_SearchHistoryRepository_fetch_shouldReturnSearchHistories() {
        // Given
        
        // When
        guard let result = try? repository.fetch()
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertEqual(result, dev.searchHistoryDataStore.searchHistories)
    }
    
    func test_SearchHistoryRepository_saveSuccess_shouldReturnSavedSearchHistory() {
        // Given
        let searchHistory = SearchHistory(id: 1, ingredients: generateRandomIngredients())
        
        // When
        guard let results = try? repository.save(searchHistory)
            .toBlocking()
            .toArray() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertEqual(dev.searchHistoryDataStore.searchHistories, results)
    }
    
    func test_SearchHistoryRepository_saveFail_shouldReturnError() {
        // Given
        
        // When
        
        // Then
    }
    
    func test_SearchHistoryRepository_updateSuccess_shouldReturnSearchHistory() {
        // Given
        dev.searchHistoryDataStore.searchHistories = [
            SearchHistory(id: 1, ingredients: generateRandomIngredients()),
            SearchHistory(id: 2, ingredients: generateRandomIngredients()),
            SearchHistory(id: 3, ingredients: generateRandomIngredients()),
            SearchHistory(id: 4, ingredients: generateRandomIngredients()),
        ]
        let randomId = Int.random(in: 1...dev.searchHistoryDataStore.searchHistories.count)
        let newIngredients = generateRandomIngredients()
        let newSearchHistory = SearchHistory(id: randomId, ingredients: newIngredients)
        
        // When
        guard let result = try? repository.update(newSearchHistory)
            .toBlocking()
            .toArray() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        let updatedSearchHistory = result.first(where: { $0.id == randomId })
        XCTAssertEqual(updatedSearchHistory, newSearchHistory)
    }
    
    func test_SearchHistoryRepository_updateFail_shouldReturnSearchHistory() {
        // Given
        dev.searchHistoryDataStore.searchHistories = [
            SearchHistory(id: 1, ingredients: generateRandomIngredients()),
            SearchHistory(id: 2, ingredients: generateRandomIngredients()),
            SearchHistory(id: 3, ingredients: generateRandomIngredients()),
            SearchHistory(id: 4, ingredients: generateRandomIngredients()),
        ]
        let randomId = Int.random(in: (dev.searchHistoryDataStore.searchHistories.count + 1)...100)
        let newIngredients = generateRandomIngredients()
        let newSearchHistory = SearchHistory(id: randomId, ingredients: newIngredients)
        
        // When
        let result = repository.update(newSearchHistory)
            .toBlocking()
            .materialize()
        
        // Then
        switch result {
            case .completed:
                XCTFail("update invalid id should fail.")
            case .failed:
                break
        }
    }
    
    func test_SearchHistoryRepository_deleteSuccess_shouldReturnVoid() {
        // Given
        dev.searchHistoryDataStore.searchHistories = [
            SearchHistory(id: 1, ingredients: generateRandomIngredients()),
            SearchHistory(id: 2, ingredients: generateRandomIngredients()),
            SearchHistory(id: 3, ingredients: generateRandomIngredients()),
            SearchHistory(id: 4, ingredients: generateRandomIngredients()),
        ]
        let randomElement = dev.searchHistoryDataStore.searchHistories.randomElement()!
        
        // When
        let result = repository.delete(randomElement)
            .toBlocking()
            .materialize()
        
        // Then
        switch result {
            case .completed:
                break
            case .failed:
                XCTFail("failed" + getLocation())
        }
    }
    
    func test_SearchHistoryRepository_deleteFail_shouldReturnError() {
        // Given
        dev.searchHistoryDataStore.searchHistories = [
            SearchHistory(id: 1, ingredients: generateRandomIngredients()),
            SearchHistory(id: 2, ingredients: generateRandomIngredients()),
            SearchHistory(id: 3, ingredients: generateRandomIngredients()),
            SearchHistory(id: 4, ingredients: generateRandomIngredients()),
        ]
        let invalidElement = SearchHistory(
            id: dev.searchHistoryDataStore.searchHistories.count + 100,
            ingredients: generateRandomIngredients()
        )
        
        // When
        let result = repository.delete(invalidElement)
            .toBlocking()
            .materialize()
        
        // Then
        switch result {
            case .completed:
                XCTFail("delete invalid item should fail.")
            case .failed:
                break
        }
    }
    
    private func generateRandomIngredients() -> [Ingredient] {
        var ingredients = [Ingredient]()
        for i in 1...Int.random(in: 2...20) {
            ingredients.append(Ingredient(
                id: i,
                name: generateRandomString(),
                detail: nil,
                isMainIngredient: false
            ))
        }
        return ingredients
    }
}
