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
    
    // MARK: - DataStores
    let pictureIngredientDataStore = FakePictureIngredientDataStore()
    let succeedTokenDataStore = FakeTokenDataStore(isSucceedCase: true)
    let failTokenDataStore = FakeTokenDataStore(isSucceedCase: false)
}