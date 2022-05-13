//
//  CheckIngredientViewModelTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/10.
//

import XCTest
import RxSwift
import RxBlocking
import RxTest
@testable import Reciptopia

class CheckIngredientViewModelTests: XCTestCase {

    var viewModel: CheckIngredientViewModel!
    var scheduler: TestScheduler!
    var subscription: Disposable!
    let fakeIngredients = [
        Ingredient(name: "스팸"),
        Ingredient(name: "다진마늘"),
        Ingredient(name: "김치"),
        Ingredient(name: "대파"),
        Ingredient(name: "참치"),
    ]
    
    override func setUp() {
        self.viewModel = CheckIngredientViewModel(ingredients: fakeIngredients)
        self.scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDown() {
        scheduler.scheduleAt(1000) {
            self.subscription.dispose()
        }
        scheduler = nil
        super.tearDown()
    }
    
    func test_CheckIngredientViewModel_toggleStateAtIndex_shouldChangeIngredientStateAtIndex() {
        // Given
        var randomIndicesSet = Set<Int>()
        let ingredientCount = viewModel.ingredients.value.count
        for _ in 1...10 { randomIndicesSet.insert(Int.random(in: 0..<ingredientCount)) }
        let randomIndices = Array(randomIndicesSet)
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: randomIndices))
        
        // When
        subscription = observable.bind(onNext: { [weak self] index in
            self?.viewModel.toggleState(at: index)
        })
        
        scheduler.start()
        
        // Then
        let result = viewModel.ingredients.value
        
        for index in randomIndices {
            XCTAssertTrue(result[index].isMainIngredient)
        }
    }
    
    func test_CheckIngredientViewModel_addIngredient_shouldAppendIngredientUnderMaxCount() {
        // Given
        let randomIngredientNames = [String](repeating: generateRandomString(), count: Int.random(in: 1...100))
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: randomIngredientNames))
        
        // When
        subscription = observable.bind(onNext: { [weak self] ingredientName in
            self?.viewModel.addIngredient(ingredientName)
        })
        
        scheduler.start()
        
        // Then
        let result = viewModel.ingredients.value
        let compare = fakeIngredients.map { $0.name } + randomIngredientNames
        
        XCTAssertEqual(result.count, compare.count < viewModel.maxCount ? compare.count : viewModel.maxCount)
        for i in 0..<result.count {
            XCTAssertEqual(result[i].name, compare[i])
        }
    }

    func test_CheckIngredientViewModel_removeIngredientAtValidIndex_shouldRemoveIngredient() {
        // Given
        var randomIndicesSet = Set<Int>()
        let ingredientCount = viewModel.ingredients.value.count
        for _ in 1...10 { randomIndicesSet.insert(Int.random(in: 0..<ingredientCount)) }
        let randomIndices = Array(randomIndicesSet).sorted(by: >)
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: randomIndices))
        
        // When
        subscription = observable.bind(onNext: { [weak self] index in
            self?.viewModel.removeIngredient(at: index)
        })
        
        scheduler.start()
        
        // Then
        let result = viewModel.ingredients.value
        
        XCTAssertEqual(result.count, ingredientCount - randomIndices.count)
    }

    func test_CheckIngredientViewModel_removeIngredientAtInvalidIndex_shouldNotRemoveIngredient() {
        // Given
        var randomIndicesSet = Set<Int>()
        let ingredientCount = viewModel.ingredients.value.count
        for _ in 1...100 {
            randomIndicesSet.insert(
                Int.random(in: (ingredientCount + 1)..<(ingredientCount + 100))
            )
        }
        let randomIndices = Array(randomIndicesSet)
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: randomIndices))
        
        // When
        subscription = observable.bind(onNext: { [weak self] index in
            self?.viewModel.removeIngredient(at: index)
        })
        
        scheduler.start()
        
        // Then
        let result = viewModel.ingredients.value
        
        XCTAssertEqual(result.count, ingredientCount)
    }
}
