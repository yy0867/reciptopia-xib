//
//  SignedInUseCasesTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/09.
//

import XCTest
import RxBlocking
@testable import Reciptopia

class SignedInUseCasesTests: XCTestCase {
    
    var succeedSignedInUseCases: SignedInUseCases!
    var failedSignedInUseCases: SignedInUseCases!
    
    override func setUp() {
        self.succeedSignedInUseCases = SignedInUseCases(repository: dev.succeedUserSessionRepository)
        self.failedSignedInUseCases = SignedInUseCases(repository: dev.failUserSessionRepository)
    }
    
    // MARK: - Withdrawal
    func test_withdrawalUseCase_withdrawalSuccess_shouldReturnVoid() {
        // Given
        
        // When
        let result = succeedSignedInUseCases.withdrawalUseCase
            .execute()
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
    
    func test_withdrawalUseCase_withdrawalFailed_shouldReturnError() {
        // Given
        
        // When
        let result = failedSignedInUseCases.withdrawalUseCase
            .execute()
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
    
    // MARK: - Sign Out
    func test_signOutUseCase_signOutSuccess_shouldReturnVoid() {
        // Given
        
        // When
        let result = succeedSignedInUseCases.signOutUseCase
            .execute()
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
    
    func test_signOutUseCase_signOutFailed_shouldReturnError() {
        // Given
        
        // When
        let result = failedSignedInUseCases.signOutUseCase
            .execute()
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
}
