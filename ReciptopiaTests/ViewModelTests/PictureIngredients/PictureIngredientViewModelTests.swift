//
//  PictureIngredientViewModelTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/09.
//

import XCTest
import RxSwift
import RxBlocking
import RxTest
@testable import Reciptopia

class PictureIngredientViewModelTests: XCTestCase {
    
    var viewModel: PictureIngredientViewModel!
    var scheduler: TestScheduler!
    var subscription: Disposable!
    
    override func setUp() {
        super.setUp()
        self.viewModel = PictureIngredientViewModel(useCase: dev.analyzePictureUseCase)
        self.scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDown() {
        scheduler.scheduleAt(1000) {
            self.subscription.dispose()
        }
        scheduler = nil
        super.tearDown()
    }

    func test_PictureIngredientViewModel_addPicture_shouldAddPicture() {
        // Given
        let datas = [Data](repeating: Data(), count: Int.random(in: 1..<10))
        let observables = scheduler.createColdObservable(makeRecordedEvents(by: datas))
        
        // When
        self.subscription = observables.bind(onNext: { [weak self] data in
            self?.viewModel.addPicture(data)
        })
        
        scheduler.start()
        
        // Then
        let results = viewModel.pictures.value
        XCTAssertEqual(results, datas)
    }
    
    func test_PictureIngredientViewModel_addPicturesOverMaxCount_shouldAddMaxCount() {
        // Given
        let datas = [Data](repeating: Data(), count: Int.random(in: 11..<100))
        let observables = scheduler.createColdObservable(makeRecordedEvents(by: datas))
        
        // When
        self.subscription = observables.bind(onNext: { [weak self] data in
            self?.viewModel.addPicture(data)
        })
        
        scheduler.start()
        
        // Then
        let result = viewModel.pictures.value
        XCTAssertEqual(result.count, viewModel.maxPictureCount)
    }
    
    func test_PictureIngredientViewModel_removePictureAtValidIndex_shouldRemovePicture() {
        // Given
        let datas = [Data](repeating: Data(), count: Int.random(in: 1...10))
        let validIndices = Array(Array(0..<datas.count).reversed())
        let observables = scheduler.createColdObservable(makeRecordedEvents(by: validIndices))
        
        for data in datas { viewModel.pictures.append(data) }
        
        // When
        self.subscription = observables.bind(onNext: { [weak self] index in
            self?.viewModel.removePicture(at: index)
        })
        
        scheduler.start()
        
        // Then
        let result = viewModel.pictures.value
        XCTAssertTrue(result.isEmpty)
    }
    
    func test_PictureIngredientViewModel_removePictureAtInvalidIndex_shouldNotRemovePicture() {
        // Given
        let datas = [Data](repeating: Data(), count: Int.random(in: 1...10))
        let invalidIndices = Array(11..<100)
        let observables = scheduler.createColdObservable(makeRecordedEvents(by: invalidIndices))
        
        for data in datas { viewModel.pictures.append(data) }
        
        // When
        self.subscription = observables.bind(onNext: { [weak self] index in
            self?.viewModel.removePicture(at: index)
        })
        
        scheduler.start()
        
        // Then
        let result = viewModel.pictures.value
        XCTAssertEqual(result, datas)
    }
}
