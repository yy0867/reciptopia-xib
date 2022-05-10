//
//  PictureIngredientViewControllerTests.swift
//  ReciptopiaUITests
//
//  Created by 김세영 on 2022/05/10.
//

import XCTest

class PictureIngredientViewControllerTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        self.app = XCUIApplication()
        app.launch()
    }

    func test_PictureIngredientViewController_takePhoto_shouldBindPictureCountToButtons() {
        let randomCount = Int.random(in: 1...10)
        app.tapButton("camera", count: randomCount)
        
        let managePictureButton = app.buttons["managePictureButton"]
        let analyzePictureButton = app.buttons["analyzePictureButton"]
        
        XCTAssertEqual(managePictureButton.label, "\(randomCount) / 10")
        XCTAssertEqual(analyzePictureButton.label, "\(randomCount)개의 재료 분석하기")
        XCTAssertTrue(managePictureButton.isEnabled)
        XCTAssertTrue(analyzePictureButton.isEnabled)
    }
    
    func test_PictureIngredientViewController_pictureEmpty_shouldBindEmptyStateToButtons() {
        let managePictureButton = app.buttons["managePictureButton"]
        let analyzePictureButton = app.buttons["analyzePictureButton"]
        let albumButton = app.buttons["albumButton"]
        let takePhotoButton = app.buttons["cameraButton"]
        
        XCTAssertFalse(managePictureButton.isEnabled)
        XCTAssertFalse(analyzePictureButton.isEnabled)
        XCTAssertTrue(albumButton.isEnabled)
        XCTAssertTrue(takePhotoButton.isEnabled)
    }
    
    func test_PictureIngredientViewController_pictureFull_shouldBindFullStateToButtons() {
        let managePictureButton = app.buttons["managePictureButton"]
        let analyzePictureButton = app.buttons["analyzePictureButton"]
        let albumButton = app.buttons["albumButton"]
        let takePhotoButton = app.buttons["cameraButton"]
        
        let randomCount = Int.random(in: 11...30)
        app.tapButton("cameraButton", count: randomCount)
        
        XCTAssertEqual(managePictureButton.label, "10 / 10")
        XCTAssertEqual(analyzePictureButton.label, "10개의 재료 분석하기")
        XCTAssertTrue(managePictureButton.isEnabled)
        XCTAssertTrue(analyzePictureButton.isEnabled)
        XCTAssertFalse(albumButton.isEnabled)
        XCTAssertFalse(takePhotoButton.isEnabled)
    }
}
