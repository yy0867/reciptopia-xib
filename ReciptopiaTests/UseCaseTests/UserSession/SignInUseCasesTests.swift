//
//  SignInUseCasesTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/09.
//

import XCTest
import RxBlocking
@testable import Reciptopia

class SignInUseCasesTests: XCTestCase {
    
    var succeedSignInUseCases: SignInUseCases!
    var failedSignInUseCases: SignInUseCases!
    
    override func setUp() {
        self.succeedSignInUseCases = SignInUseCases(repository: dev.succeedUserSessionRepository)
        self.failedSignInUseCases = SignInUseCases(repository: dev.failUserSessionRepository)
    }
    
    // MARK: - Sign In
    func test_signInUseCase_signInSuccess_shouldReturnUserSession() {
        // Given
        let email = "email@example.com"
        let password = "password"
        
        // When
        let result = try? succeedSignInUseCases.signInUseCase
            .execute(email: email, password: password)
            .toBlocking()
            .first()
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.account.email, email)
    }
    
    func test_signInUseCase_signInFailed_shouldReturnSignInFailError() {
        // Given
        let email = "email@example.com"
        let password = "password"
        
        // When
        let result = failedSignInUseCases.signInUseCase
            .execute(email: email, password: password)
            .toBlocking()
            .materialize()
        
        // Then
        switch result {
            case .completed:
                XCTFail("failed" + getLocation())
            case .failed(_, let error):
                XCTAssertEqual(error as? ReciptopiaError, ReciptopiaError.signInFail)
        }
    }
    
    // MARK: - Remember Me
    func test_rememberMeUseCase_rememberMeSuccess_shouldReturnUserSession() {
        // Given
        
        // When
        guard let result = try? succeedSignInUseCases.rememberMeUseCase
            .execute()
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertNotNil(result)
    }
    
    func test_rememberMeUseCase_rememberMeFailed_shouldReturnNil() {
        // Given
        
        // When
        guard let result = try? failedSignInUseCases.rememberMeUseCase
            .execute()
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertNil(result)
    }
}
