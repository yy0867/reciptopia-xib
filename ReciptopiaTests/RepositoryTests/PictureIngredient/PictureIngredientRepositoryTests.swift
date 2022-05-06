//
//  PictureIngredientRepositoryTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/06.
//

import XCTest
import RxBlocking
import RxSwift
@testable import Reciptopia

class PictureIngredientRepositoryTests: XCTestCase {
    
    var repository: PictureIngredientRepositoryProtocol!
    
    override func setUp() {
        self.repository = PictureIngredientRepository(dataStore: dev.pictureIngredientDataStore)
    }
    
    func test_PictureIngredientRepository_analyze_shouldReturnIngredientNames() {
        // Given
        let ingredients = [
            "스팸",
            "김치",
            "다진마늘",
        ]
        
        // When
        guard let receivedValue = try? repository
            .analyze([Data](repeating: Data(), count: 10))
            .toBlocking()
            .first() else {
            XCTFail("\(#function) \(#line) fails.")
            return
        }
        
        // Then
        XCTAssertEqual(ingredients, receivedValue)
    }
}
