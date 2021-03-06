//
//  DevInstances.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/06.
//

import XCTest
import RxSwift
import RxRelay
@testable import Reciptopia

extension XCTestCase {
    
    var dev: DevInstances {
        return DevInstances.shared
    }
    
    func getLocation(_ file: String = #file, _ function: String = #function) -> String {
        return " at \(file) - \(function)"
    }
}

struct DevInstances {
    
    static let shared = DevInstances()
    
    // MARK: - Properties
    let fakeAccount = Account(
        id: 1,
        email: "email@example.com",
        password: "password",
        nickname: "nickname",
        profilePictureUrl: "https://www.example.com"
    )
    
    // MARK: - UseCases
    let analyzePictureUseCase = FakeAnalyzePictureUseCase()
    
    // MARK: - Repositories
    let pictureIngredientRepository = FakePictureIngredientRepository()
    
    let succeedUserSessionRepository = FakeUserSessionRepository(isSucceedCase: true)
    let failUserSessionRepository = FakeUserSessionRepository(isSucceedCase: false)
    
    let searchHistoryRepository: SearchHistoryRepositoryProtocol
    let favoriteRepository: FavoriteRepositoryProtocol
    
    // MARK: - DataStores
    let pictureIngredientDataStore = FakePictureIngredientDataStore()
    
    let succeedTokenDataStore = FakeTokenDataStore(isSucceedCase: true)
    let failTokenDataStore = FakeTokenDataStore(isSucceedCase: false)
    
    let searchHistoryDataStore = FakeSearchHistoryDataStore()
    let favoriteDataStore = FakeFavoriteDataStore()
    
    var searchHistoryDataStoreRelay: BehaviorRelay<SearchHistoryDataStoreProtocol>!
    var favoriteDataStoreRelay: BehaviorRelay<FavoriteDataStoreProtocol>!
    
    let succeedPostDataStore = FakePostDataStore(isSucceedCase: true)
    let failPostDataStore = FakePostDataStore(isSucceedCase: false)
    
    // MARK: - Init
    init() {
        searchHistoryDataStoreRelay = BehaviorRelay(value: searchHistoryDataStore)
        favoriteDataStoreRelay = BehaviorRelay(value: favoriteDataStore)
        
        self.searchHistoryRepository = SearchHistoryRepository(dataStore: searchHistoryDataStoreRelay)
        self.favoriteRepository = FavoriteRepository(dataStore: favoriteDataStoreRelay)
    }
    
    // MARK: - Methods
    static func generateRandomString(length: Int = 10) -> String {
        let pool = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var generatedString = ""
        for _ in 0..<length {
            generatedString.append(pool.randomElement()!)
        }
        return generatedString
    }
    
    static func generateRandomIngredients(_ length: Int = 10) -> [Ingredient] {
        var ingredients = [Ingredient]()
        for _ in 1...length {
            ingredients.append(
                Ingredient(name: generateRandomString())
            )
        }
        return ingredients
    }
    
    static func generateRandomPost(id: Int) -> Post {
        return Post(
            id: id,
            ownerId: id,
            title: generateRandomString(),
            content: generateRandomString(length: 100),
            pictureUrls: [String](repeating: "https://www.example.com", count: 10),
            views: Int.random(in: 1...10000)
        )
    }
}
