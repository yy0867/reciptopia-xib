//
//  PictureIngredientRepositoryTests.swift
//  ReciptopiaKitTests
//
//  Created by 김세영 on 2022/05/06.
//

import XCTest
import RxBlocking
import RxTest
@testable import ReciptopiaKit

class PictureIngredientRepositoryTests: XCTestCase {
    
    var pictureIngredientRepository: PictureIngredientRepositoryProtocol!
    var pictures = [Data]()
    
    override func setUp() {
        for _ in 1...Int.random(in: 2...10) {
            pictures.append(Data())
        }
    }
    
    func test_PictureIngredientRepository_analyze_shouldReturnAnalyzedString() {
        // Given
        
        // When
        let subscribe = pictureIngredientRepository.analyze(pictures)
        
        // Then
        do {
            let receivedValue = try subscribe.toBlocking().first()
            XCTAssertEqual(receivedValue, [])
        } catch {
            XCTFail("\(#function) fails.")
        }
        
    }
}
