//
//  PictureIngredientUseCaseTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/06.
//

import XCTest
import RxBlocking
@testable import Reciptopia

class AnalyzePictureUseCaseTests: XCTestCase {
    
    var useCase: AnalyzePictureUseCaseProtocol!
    
    override func setUp() {
        self.useCase = AnalyzePictureUseCase(repository: dev.pictureIngredientRepository)
    }
    
    func test_AnalyzePictureUseCase_execute_shouldReturnIngredients() {
        // Given
        let ingredients = [
            Ingredient(name: "스팸"),
            Ingredient(name: "김치"),
            Ingredient(name: "다진마늘"),
        ]
        
        // When
        guard let receivedValue = try? useCase
            .execute([Data](repeating: Data(), count: 10))
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertEqual(ingredients, receivedValue)
    }
}
