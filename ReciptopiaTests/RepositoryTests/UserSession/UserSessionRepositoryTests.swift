//
//  UserSessionRepositoryTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/07.
//

import XCTest
import RxTest
import RxBlocking
@testable import Reciptopia

class UserSessionRepositoryTests: XCTestCase {
    
    var repository: UserSessionRepositoryProtocol!
    
    let fakeCredential = Credential(email: "email@example.com", password: "password")
    
    func test_UserSessionRepository_signInSuccess_shouldReturnUserSession() {
        // Given
        repository = UserSessionRepository(dataStore: dev.succeedTokenDataStore)
        
        // When
        guard let userSession = try? repository.signIn(credential: fakeCredential)
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertNil(userSession.account.password)
        XCTAssertEqual(userSession.token, "token")
        XCTAssertEqual(userSession.account.email, fakeCredential.email)
        XCTAssertEqual(userSession.account.nickname, "nickname")
    }
    
    func test_UserSessionRepository_signUpSuccess_shouldReturnAccount() {
        // Given
        repository = UserSessionRepository(dataStore: dev.failTokenDataStore)
        
        // When
        guard let account = try? repository.signUp(credential: fakeCredential, nickname: "nickname")
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertNil(account.password)
        XCTAssertEqual(account.email, fakeCredential.email)
        XCTAssertEqual(account.nickname, "nickname")
    }
    
    func test_UserSessionRepository_rememberMeSuccess_shouldReturnUserSession() {
        // Given
        repository = UserSessionRepository(dataStore: dev.succeedTokenDataStore)
        
        // When
        guard let userSession = try? repository.rememberMe()
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertNotNil(userSession)
        XCTAssertEqual(userSession?.token, "token")
    }
    
    func test_UserSessionRepository_rememberMeFailed_shouldReturnNil() {
        // Given
        repository = UserSessionRepository(dataStore: dev.failTokenDataStore)
        
        // When
        guard let userSession = try? repository.rememberMe()
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertNil(userSession)
    }
    
    func test_UserSessionRepository_signOutSuccess_shouldReturnVoid() {
        // Given
        repository = UserSessionRepository(dataStore: dev.succeedTokenDataStore)
        
        // When
        let result = repository.signOut()
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
    
    func test_UserSessionRepository_signOutFailed_shouldReturnError() {
        // Given
        repository = UserSessionRepository(dataStore: dev.failTokenDataStore)
        
        // When
        let result = repository.signOut()
            .toBlocking()
            .materialize()
        
        // Then
        switch result {
            case .completed:
                XCTFail("Should return error" + getLocation())
            case .failed(_, let error):
                XCTAssertEqual(error as? ReciptopiaError, ReciptopiaError.notFound)
        }
    }
    
    func test_UserSessionRepository_isExists_shouldReturnTrue() {
        // Given
        
        
        // When
        
        // Then
    }
    
    func test_UserSessionRepository_isNotExists_shouldReturnFalse() {
        // Given
        
        // When
        
        // Then
    }
    
    func test_UserSessionRepository_withdrawal_shouldReturnVoid() {
        // Given
        repository = UserSessionRepository(dataStore: dev.succeedTokenDataStore)
        
        // When
        let result = repository.withdrawal()
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
    
    func test_UserSessionRepository_withdrawal_shouldReturnError() {
        // Given
        repository = UserSessionRepository(dataStore: dev.failTokenDataStore)
        
        // When
        let result = repository.withdrawal()
            .toBlocking()
            .materialize()
        
        // Then
        switch result {
            case .completed:
                XCTFail("Should return error" + getLocation())
            case .failed(_, let error):
                XCTAssertEqual(error as? ReciptopiaError, ReciptopiaError.notFound)
        }
    }
}
