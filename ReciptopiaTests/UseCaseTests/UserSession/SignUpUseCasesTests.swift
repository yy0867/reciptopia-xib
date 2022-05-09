//
//  SignUpUseCasesTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/09.
//

import XCTest
import RxBlocking
@testable import Reciptopia

class SignUpUseCasesTests: XCTestCase {
    
    var succeedSignUpUseCases: SignUpUseCases!
    var failedSignUpUseCases: SignUpUseCases!
    
    override func setUp() {
        self.succeedSignUpUseCases = SignUpUseCases(repository: dev.succeedUserSessionRepository)
        self.failedSignUpUseCases = SignUpUseCases(repository: dev.failUserSessionRepository)
    }
    
    // MARK: Sign Up
    func test_signUpUseCase_signUpSuccess_shouldReturnCreatedAccount() {
        // Given
        let account = dev.fakeAccount
        
        // When
        guard let result = try? succeedSignUpUseCases.signUpUseCase.execute(
            email: account.email,
            password: account.password!,
            nickname: account.nickname
        )
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertNil(result.password)
        XCTAssertEqual(result.email, account.email)
        XCTAssertEqual(result.nickname, account.nickname)
    }
    
    func test_signUpUseCase_signUpFailed_shouldReturnError() {
        // Given
        let account = dev.fakeAccount
        
        // When
        let result = failedSignUpUseCases.signUpUseCase.execute(
            email: account.email,
            password: account.password!,
            nickname: account.nickname
        )
            .toBlocking()
            .materialize()
        
        // Then
        switch result {
            case .completed:
                XCTFail("failed" + getLocation())
            case .failed:
                break
        }
    }
    
    // MARK: Check Email Exist
    func test_checkEmailExistsUseCase_emailNotExists_shouldReturnFalse() {
        // Given
        let email = "email@example.com"
        
        // When
        guard let result = try? succeedSignUpUseCases.checkEmailExistsUseCase.execute(email: email)
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertFalse(result)
    }
    
    func test_checkEmailExistsUseCase_emailExists_shouldReturnTrue() {
        // Given
        let email = "email@example.com"
        
        // When
        guard let result = try? failedSignUpUseCases.checkEmailExistsUseCase.execute(email: email)
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertTrue(result)
    }
}
