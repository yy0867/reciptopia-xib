//
//  SearchIngredientViewModelTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/20.
//

import XCTest
import RxTest
import RxBlocking
import RxSwift
@testable import Reciptopia

class SearchIngredientViewModelTests: XCTestCase {

    var viewModel: SearchIngredientViewModel!
    var scheduler: TestScheduler!
    var subscription: Disposable!
    
    override func setUp() {
        self.viewModel = SearchIngredientViewModel()
        self.scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDown() {
        self.scheduler.scheduleAt(1000) { [weak self] in
            self?.subscription.dispose()
        }
        self.scheduler = nil
        
        super.tearDown()
    }
    
    func test_SearchIngredientViewModel_addIngredient_shouldAddIngredient() {
        // Given
        var randomStrings = [String]()
        for _ in 1...Int.random(in: 2...10) {
            randomStrings.append(generateRandomString())
        }
        
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: randomStrings))
        
        // When
        subscription = observable.bind(onNext: { [weak self] ingredientName in
            self?.viewModel.addIngredient(ingredientName)
        })
        
        scheduler.start()
        
        // Then
        let result = viewModel.ingredients.value
        XCTAssertEqual(randomStrings.count, result.count)
        for i in 0..<result.count {
            XCTAssertEqual(randomStrings[i], result[i].name)
            XCTAssertFalse(result[i].isMainIngredient)
        }
    }
    
    func test_SearchIngredientViewModel_addIngredientOverMaxCount_shouldAddIngredientUnderMaxCount() {
        // Given
        var randomStrings = [String]()
        for _ in 11...Int.random(in: 20...100) {
            randomStrings.append(generateRandomString())
        }
        
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: randomStrings))
        
        // When
        subscription = observable.bind(onNext: { [weak self] ingredientName in
            self?.viewModel.addIngredient(ingredientName)
        })
        
        scheduler.start()
        
        // Then
        let result = viewModel.ingredients.value
        XCTAssertEqual(result.count, viewModel.maxCount)
        for i in 0..<result.count {
            XCTAssertEqual(randomStrings[i], result[i].name)
            XCTAssertFalse(result[i].isMainIngredient)
        }
    }
    
    func test_SearchIngredientViewModel_setIngredients_shouldAcceptInputIngredients() {
        // Given
        let ingredients = generateRandomIngredients()
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: [()]))
        
        // When
        subscription = observable.bind(onNext: { [weak self] _ in
            self?.viewModel.setIngredients(ingredients)
        })
        
        scheduler.start()
        
        // Then
        let result = viewModel.ingredients.value
        XCTAssertEqual(ingredients, result)
    }
    
    func test_SearchIngredientViewModel_setIngredientsOverMaxCount_shouldAcceptInputIngredientsFromFirstToMaxCount() {
        // Given
        let ingredients = generateRandomIngredients(minLength: 11, range: 100)
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: [()]))
        
        // When
        subscription = observable.bind(onNext: { [weak self] _ in
            self?.viewModel.setIngredients(ingredients)
        })
        
        scheduler.start()
        
        // Then
        let result = viewModel.ingredients.value
        XCTAssertEqual(result.count, viewModel.maxCount)
        for i in 0..<viewModel.maxCount {
            XCTAssertEqual(result[i], ingredients[i])
        }
    }
    
    func test_SearchIngredientViewModel_toggleStateAtIndex_shouldToggleStateAtIndex() {
        // Given
        let ingredients = generateRandomIngredients()
        viewModel.ingredients.accept(ingredients)
        
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
        
        for i in 0..<result.count {
            if randomIndices.contains(i) { XCTAssertTrue(result[i].isMainIngredient) }
            else { XCTAssertFalse(result[i].isMainIngredient) }
        }
    }
    
    func test_SearchIngredientViewModel_removeIngredientAtValidIndex_shouldRemoveIngredient() {
        // Given
        let ingredients = generateRandomIngredients()
        viewModel.ingredients.accept(ingredients)
        
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
    
    func test_SearchIngredientViewModel_removeIngredientAtInvalidIndex_shouldNotRemoveIngredient() {
        // Given
        let ingredients = generateRandomIngredients()
        viewModel.ingredients.accept(ingredients)
        
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
    
    private func generateRandomIngredients(minLength: Int = 1, range: Int = 10) -> [Ingredient] {
        var ingredients = [Ingredient]()
        for _ in minLength...(minLength + range - 1) {
            ingredients.append(
                Ingredient(name: generateRandomString(), isMainIngredient: false)
            )
        }
        return ingredients
    }
}
