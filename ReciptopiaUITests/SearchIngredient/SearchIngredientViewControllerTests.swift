//
//  SearchIngredientViewControllerTests.swift
//  ReciptopiaUITests
//
//  Created by 김세영 on 2022/05/21.
//

import XCTest

class SearchIngredientViewControllerTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        self.app = XCUIApplication()
        app.launch()
        
        app.tapButton("searchByNameButton")
    }
    
    func test_SearchIngredientViewController_addIngredient_shouldAddIngredient() {
        let searchBar = app.searchFields.firstMatch
        
        for i in 1...Int.random(in: 3...10) {
            searchBar.typeText("Ingredient \(i)")
            searchBar.typeText("\n")
        }
        
        // expect at least 3 cells shown in screen
        let cellCount = app.collectionViews.firstMatch.cells.count
        XCTAssertGreaterThanOrEqual(cellCount, 3)
    }
    
    func test_SearchIngredientViewController_removeIngredient_shouldRemoveIngredient() {
        let searchBar = app.searchFields.firstMatch
        
        let randomCount = Int.random(in: 3...10)
        for i in 1...randomCount {
            searchBar.typeText("Ingredient \(i)")
            searchBar.typeText("\n")
        }
        
        // remove all cells
        for _ in 1...randomCount {
            app.buttons["ingredientCellRemoveButton"].firstMatch.tap()
        }
        
        let cellCount = app.collectionViews.firstMatch.cells.count
        XCTAssertEqual(cellCount, 0)
    }
    
    func test_SearchIngredientViewController_selectPage_shouldChangePage() {
        let segmentedControl = app.segmentedControls.firstMatch
        
        let firstTableView = app.tables.firstMatch
        segmentedControl.buttons["즐겨찾기"].tap()
        let secondTableView = app.tables.firstMatch
        
        XCTAssertNotEqual(firstTableView, secondTableView)
    }
}
