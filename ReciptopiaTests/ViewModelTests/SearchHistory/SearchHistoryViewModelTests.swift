//
//  SearchHistoryViewModelTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/13.
//

import XCTest
import RxBlocking
import RxTest
import RxSwift
@testable import Reciptopia

class SearchHistoryViewModelTests: XCTestCase {
    
    var viewModel: SearchHistoryViewModel!
    var scheduler: TestScheduler!
    var subscription: Disposable!
    
    override func setUp() {
        dev.searchHistoryDataStore.searchHistories = generateRandomHistories()
        self.viewModel = SearchHistoryViewModel(repository: dev.searchHistoryRepository)
        self.scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDown() {
        self.scheduler.scheduleAt(1000) { [weak self] in
            self?.subscription.dispose()
        }
        self.scheduler = nil
        super.tearDown()
    }
    
    func test_SearchHistoryViewModel_fetch_shouldEqualToHistoriesOfDataStore() {
        // Given
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: [()]))
        
        // When
        subscription = observable.bind(onNext: { [weak self] _ in
            self?.viewModel.fetch()
        })
        
        scheduler.start()
        
        guard let result = try? viewModel.histories
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertEqual(result, dev.searchHistoryDataStore.searchHistories)
    }
    
    func test_SearchHistoryViewModel_saveIngredients_shouldAddToHistoryAtDataStoreAndFetch() {
        // Given
        let ingredients = [Ingredient](
            repeating: Ingredient(name: generateRandomString()),
            count: Int.random(in: 1...10)
        )
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: [ingredients]))
        
        // When
        subscription = observable.bind(onNext: { [weak self] ingredients in
            self?.viewModel.save(ingredients)
        })
        
        scheduler.start()
        
        guard let result = try? viewModel.histories
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertEqual(result.count, dev.searchHistoryDataStore.searchHistories.count)
        for i in 0..<result.count {
            XCTAssertEqual(
                result[i].ingredients,
                dev.searchHistoryDataStore.searchHistories[i].ingredients
            )
        }
    }
    
    func test_SearchHistoryViewModel_update_shouldUpdateTimestamp() {
        // Given
        let selectedIndex = dev.searchHistoryDataStore.searchHistories.indices.randomElement()!
        let targetHistory = dev.searchHistoryDataStore.searchHistories[selectedIndex]
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: [selectedIndex]))
        viewModel.histories.accept(dev.searchHistoryDataStore.searchHistories)
        
        // When
        subscription = observable.bind(onNext: { [weak self] index in
            self?.viewModel.update(at: index)
        })
        
        scheduler.start()
        
        guard let result = try? viewModel.histories
            .toBlocking()
            .first(),
              let updatedHistory = result.first(where: { $0.id == targetHistory.id }) else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertLessThan(targetHistory.timestamp, updatedHistory.timestamp)
    }
    
    func test_SearchHistoryViewModel_delete_shouldDeleteHistoryAndFetch() {
        // Given
        let selectedIndex = dev.searchHistoryDataStore.searchHistories.indices.randomElement()!
        let targetHistory = dev.searchHistoryDataStore.searchHistories[selectedIndex]
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: [selectedIndex]))
        viewModel.histories.accept(dev.searchHistoryDataStore.searchHistories)
        
        // When
        subscription = observable.bind(onNext: { [weak self] index in
            self?.viewModel.delete(at: index)
        })
        
        scheduler.start()
        
        guard let result = try? viewModel.histories
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertFalse(result.contains(targetHistory))
    }
    
    private func generateRandomHistories() -> [SearchHistory] {
        var histories = [SearchHistory]()
        for i in 1...Int.random(in: 10...100) {
            histories.append(SearchHistory(
                id: i,
                ingredients: [Ingredient](
                    repeating: Ingredient(name: generateRandomString()),
                    count: Int.random(in: 1...10))
                ,
                timestamp: Date.timestamp.addingTimeInterval(-100))
            )
        }
        return histories
    }
}
