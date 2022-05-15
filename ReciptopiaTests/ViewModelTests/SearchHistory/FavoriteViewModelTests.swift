//
//  FavoriteViewModelTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/15.
//

import XCTest
import RxBlocking
import RxTest
import RxSwift
@testable import Reciptopia

class FavoriteViewModelTests: XCTestCase {
    
    var viewModel: FavoriteViewModel!
    var scheduler: TestScheduler!
    var subscription: Disposable!
    
    override func setUp() {
        self.scheduler = TestScheduler(initialClock: 0)
        dev.favoriteDataStore.favorites = generateRandomFavorites()
        self.viewModel = FavoriteViewModel(repository: dev.favoriteRepository)
    }
    
    override func tearDown() {
        self.scheduler.scheduleAt(1000) { [weak self] in
            self?.subscription.dispose()
        }
        self.scheduler = nil
        super.tearDown()
    }

    func test_FavoriteViewModel_fetch_shouldEqualToFavoritesOfDataStore() {
        // Given
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: [()]))
        
        // When
        subscription = observable.bind(onNext: { [weak self] in
            self?.viewModel.fetch()
        })
        
        guard let result = try? viewModel.favorites
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertEqual(result, dev.favoriteDataStore.favorites)
    }
    
    func test_FavoriteViewModel_savePost_shouldConvertPostToFavoriteAndAddToFavoritesOfDataStoreAndFetch() {
        // Given
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: [()]))
        let post = Post(
            ownerId: 1,
            title: generateRandomString(),
            content: generateRandomString(length: 100),
            pictureUrls: [
                "https://www.example.com",
                "https://www.example.com",
                "https://www.example.com",
                "https://www.example.com",
                "https://www.example.com",
            ],
            views: Int.random(in: 1...1000)
        )
        
        // When
        subscription = observable.bind(onNext: { [weak self] in
            self?.viewModel.save(post: post)
        })
        
        guard let result = try? viewModel.favorites
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertEqual(result.count, dev.favoriteDataStore.favorites.count)
        for i in 0..<result.count {
            XCTAssertEqual(result[i], dev.favoriteDataStore.favorites[i])
        }
    }
    
    func test_FavoriteViewModel_delete_shouldDeleteFavoriteAndFetch() {
        // Given
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: [()]))
        let targetFavorite = dev.favoriteDataStore.favorites.randomElement()!
        
        // When
        subscription = observable.bind(onNext: { [weak self] in
            self?.viewModel.delete(targetFavorite)
        })
        
        guard let result = try? viewModel.favorites
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertFalse(result.contains(targetFavorite))
    }
    
    private func generateRandomFavorites() -> [Favorite] {
        var favorites = [Favorite]()
        for i in 1...Int.random(in: 10...100) {
            favorites.append(
                Favorite(id: i, postId: i, title: generateRandomString())
            )
        }
        return favorites
    }
}
