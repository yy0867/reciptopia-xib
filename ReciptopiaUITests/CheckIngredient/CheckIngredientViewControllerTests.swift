//
//  CheckIngredientViewControllerTests.swift
//  ReciptopiaUITests
//
//  Created by 김세영 on 2022/05/11.
//

import XCTest
@testable import Reciptopia

class CheckIngredientViewControllerTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        self.app = XCUIApplication()
        app.launch()
        
        app.tapButton("cameraButton")
        app.tapButton("analyzePictureButton")
    }
    
    func test_CheckIngredientViewController_removeIngredient_shouldRemoveIngredient() {
        // expect 3 ingredients
        for _ in 1...3 {
            app.buttons["ingredientCellRemoveButton"].firstMatch.tap()
        }
        
        let findRecipeButton = app.buttons["findRecipeButton"]
        XCTAssertFalse(findRecipeButton.isEnabled)
        XCTAssertEqual(findRecipeButton.label, "검색할 재료를 추가해주세요.")
    }
}
