//
//  ManagePictureViewControllerTests.swift
//  ReciptopiaUITests
//
//  Created by 김세영 on 2022/05/10.
//

import XCTest

class ManagePictureViewControllerTests: XCTestCase {
    
    var app: XCUIApplication!
    var randomCount: Int!

    override func setUp() {
        self.app = XCUIApplication()
        app.launch()
        
        self.randomCount = Int.random(in: 1...10)
        app.tapButton("cameraButton", count: randomCount)
        app.tapButton("managePictureButton")
    }
    
    func test_ManagePictureViewController_collectionView_shouldShowImages() {
        XCTAssertEqual(app.collectionViews.cells.count, randomCount <= 8 ? randomCount : 8)
    }
    
    func test_ManagePictureViewController_imageCellRemoveButton_shouldRemoveImageAndBindLabels() {
        
        for _ in 1...randomCount {
            app.buttons["imageCellRemoveButton"].firstMatch.tap()
            
        }
        
        XCTAssertEqual(app.staticTexts["emptyPictureLabel"].label, "분석할 사진이 없습니다.")
        XCTAssertEqual(app.buttons["analyzeButton"].label, "분석할 사진이 없습니다.")
        XCTAssertFalse(app.buttons["analyzeButton"].isEnabled)
    }
}
