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
    
    class FakePictureIngredientDataStore: PictureIngredientDataStoreProtocol {
        func analyze(_ pictures: [Data]) -> Observable<[String]> {
            return Observable.create { observer in
                observer.onNext(["a", "b", "c"])
                observer.onCompleted()
                
                return Disposables.create()
            }
        }
    }
    
    var dataStore: PictureIngredientDataStoreProtocol!
    var repository: PictureIngredientRepositoryProtocol!
    
    override func setUp() {
        self.dataStore = FakePictureIngredientDataStore()
        self.repository = PictureIngredientRepository(dataStore: dataStore)
    }
    
    func test_PictureIngredientRepository_analyze_shouldReturnIngredientNames() {
        // Given
        
        // When
        guard let receivedValue = try? repository
            .analyze([Data](repeating: Data(), count: 10))
            .toBlocking()
            .first() else {
            XCTFail("\(#function) \(#line) fails.")
            return
        }
        
        // Then
        XCTAssertEqual(["a", "b", "c"], receivedValue)
    }
}
