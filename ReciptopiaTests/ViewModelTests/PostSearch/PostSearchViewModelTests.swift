//
//  PostSearchViewModelTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/23.
//

import XCTest
import RxTest
import RxSwift
import RxRelay
@testable import Reciptopia

class PostSearchViewModelTests: XCTestCase {
    
    var viewModel: PostSearchViewModel!
    var scheduler: TestScheduler!
    var subscription: Disposable!
    
    override func setUp() {
        let fakePosts = generateRandomPosts()
        dev.succeedPostDataStore.fakePosts = fakePosts
        
        let postRepository = PostRepository(dataStore: dev.succeedPostDataStore)
        let favoriteRepository = FavoriteRepository(
            dataStore: BehaviorRelay(value: dev.favoriteDataStore)
        )
        self.viewModel = PostSearchViewModel(
            ingredients: DevInstances.generateRandomIngredients(),
            postRepository: postRepository,
            favoriteRepository: favoriteRepository
        )
        self.scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDown() {
        self.scheduler.scheduleAt(1000) { [weak self] in
            self?.subscription.dispose()
        }
        self.scheduler = nil
        super.tearDown()
    }
    
    func test_PostSearchViewModel_fetch_shouldReturnPostsAtDataStore() {
        // Given
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: [()]))
        
        // When
        subscription = observable.bind(onNext: { [weak self] _ in
            self?.viewModel.fetch()
        })
        
        scheduler.start()
        
        // Then
        let result = viewModel.posts.value
        
        XCTAssertEqual(result, dev.succeedPostDataStore.fakePosts)
    }
    
    func test_PostSearchViewModel_fetchNextPage_shouldReturnPostsAtDataStore() {
        // Given
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: [()]))
        
        // When
        subscription = observable.bind(onNext: { [weak self] _ in
            self?.viewModel.fetchNextPage()
        })
        
        scheduler.start()
        
        // Then
        let result = viewModel.posts.value
        XCTAssertEqual(result, dev.succeedPostDataStore.fakePosts)
    }
    
    func test_PostSearchViewModel_addFavoriteAtIndex_shouldUpdatePostsByMappingFavorites() {
        // Given
        self.viewModel.posts.accept(dev.succeedPostDataStore.fakePosts)
        let randomIndex = Int.random(in: 0..<dev.succeedPostDataStore.fakePosts.count)
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: [randomIndex]))
        
        // When
        subscription = observable.bind(onNext: { [weak self] index in
            self?.viewModel.addFavorite(at: randomIndex)
        })
        
        scheduler.start()
        
        // Then
        let result = viewModel.posts.value[randomIndex].isFavorite
        XCTAssertTrue(result)
    }
    
    func test_PostSearchViewModel_removeFavoriteAtIndex_shouldUpdatePostsByMappingFavorites() {
        // Given
        let randomIndex = Int.random(in: 0..<dev.succeedPostDataStore.fakePosts.count)
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: [randomIndex]))
        
        // When
        subscription = observable.bind(onNext: { [weak self] index in
            self?.viewModel.removeFavorite(at: randomIndex)
        })
        
        scheduler.start()
        
        // Then
        let result = viewModel.posts.value[randomIndex].isFavorite
        XCTAssertFalse(result)
    }
    
    private func generateRandomPosts() -> [Post] {
        var posts = [Post]()
        for i in 1...20 {
            posts.append(DevInstances.generateRandomPost(id: i))
        }
        return posts
    }
}
