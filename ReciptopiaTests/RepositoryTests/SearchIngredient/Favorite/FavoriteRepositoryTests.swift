//
//  FavoriteRepositoryTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/12.
//

import XCTest
import RxBlocking
@testable import Reciptopia

class FavoriteRepositoryTests: XCTestCase {
    
    var repository: FavoriteRepositoryProtocol!
    
    override func setUp() {
        dev.favoriteDataStore.favorites = []
        self.repository = FavoriteRepository(dataStore: dev.favoriteDataStore)
    }
    
    func test_FavoriteRepository_fetch_shouldReturnFavorites() {
        // Given
        
        // When
        guard let result = try? repository.fetch()
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertEqual(result, dev.favoriteDataStore.favorites)
    }
    
    func test_FavoriteRepository_saveSuccess_shouldReturnSavedFavorite() {
        // Given
        let favorite = Favorite(id: 1, postId: 1, title: generateRandomString())
        
        // When
        guard let results = try? repository.save(favorite)
            .toBlocking()
            .toArray() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertEqual(dev.favoriteDataStore.favorites, results)
    }
    
    func test_FavoriteRepository_saveFail_shouldReturnError() {
        // Given
        
        // When
        
        // Then
    }
    
    func test_FavoriteRepository_updateSuccess_shouldReturnFavorite() {
        // Given
        dev.favoriteDataStore.favorites = generateRandomFavorites()
        
        let randomId = Int.random(in: 1...dev.favoriteDataStore.favorites.count)
        let newFavorite = Favorite(id: randomId, postId: 1, title: generateRandomString())
        
        // When
        guard let result = try? repository.update(newFavorite)
            .toBlocking()
            .toArray() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        let updatedFavorite = result.first(where: { $0.id == randomId })
        XCTAssertEqual(updatedFavorite, newFavorite)
    }
    
    func test_FavoriteRepository_updateFail_shouldReturnError() {
        // Given
        dev.favoriteDataStore.favorites = generateRandomFavorites()
        let randomId = Int.random(in: (dev.searchHistoryDataStore.searchHistories.count + 1)...100)
        let newFavorite = Favorite(id: randomId, postId: 1, title: generateRandomString())
        
        // When
        let result = repository.update(newFavorite)
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
    
    func test_FavoriteRepository_deleteSuccess_shouldReturnVoid() {
        // Given
        dev.favoriteDataStore.favorites = generateRandomFavorites()
        let randomElement = dev.favoriteDataStore.favorites.randomElement()!
        
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
    
    func test_FavoriteRepository_deleteFail_shouldReturnError() {
        // Given
        dev.favoriteDataStore.favorites = generateRandomFavorites()
        let randomElement = dev.favoriteDataStore.favorites.randomElement()!
        
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
    
    private func generateRandomFavorites() -> [Favorite] {
        var favorites = [Favorite]()
        for i in 1...Int.random(in: 2...20) {
            favorites.append(Favorite(
                id: i,
                postId: i,
                title: "Favorite \(i)"
            ))
        }
        return favorites
    }
}
