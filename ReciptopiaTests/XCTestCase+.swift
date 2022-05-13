//
//  DevInstances.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/06.
//

import XCTest
import RxSwift
@testable import Reciptopia

extension XCTestCase {
    
    var dev: DevInstances {
        return DevInstances.shared
    }
    
    func getLocation(_ file: String = #file, _ function: String = #function) -> String {
        return " at \(file) - \(function)"
    }
    
    func generateRandomString(length: Int = 10) -> String {
        let pool = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var generatedString = ""
        for _ in 0..<length {
            generatedString.append(pool.randomElement()!)
        }
        return generatedString
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
    
    // MARK: - DataStores
    let pictureIngredientDataStore = FakePictureIngredientDataStore()
    
    let succeedTokenDataStore = FakeTokenDataStore(isSucceedCase: true)
    let failTokenDataStore = FakeTokenDataStore(isSucceedCase: false)
    
    let searchHistoryDataStore = FakeSearchHistoryDataStore()
    let favoriteDataStore = FakeFavoriteDataStore()
    
    // MARK: - Init
    init() {
        self.searchHistoryRepository = SearchHistoryRepository(dataStore: searchHistoryDataStore)
    }
}
