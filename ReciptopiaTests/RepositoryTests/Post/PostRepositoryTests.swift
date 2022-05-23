//
//  PostRepositoryTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/22.
//

import XCTest
import RxBlocking
@testable import Reciptopia

class PostRepositoryTests: XCTestCase {
    
    // MARK: - Fetch
    func test_PostRepository_fetchPostsSuccess_shouldReturnPosts() {
        // Given
        let repository = PostRepository(dataStore: dev.succeedPostDataStore)
        
        let ingredients = DevInstances.generateRandomIngredients()
        let sorting = Sorting(property: .id, order: .ascending)
        let paging = Paging(page: 1)
        
        // When
        guard let result = try? repository.fetch(ingredients, paging, sorting)
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertEqual(dev.succeedPostDataStore.fakePosts, result)
    }
    
    func test_PostRepository_fetchPostsFailed_shouldReturnError() {
        // Given
        let repository = PostRepository(dataStore: dev.failPostDataStore)
        
        let ingredients = DevInstances.generateRandomIngredients()
        let sorting = Sorting(property: .id, order: .ascending)
        let paging = Paging(page: 1)
        
        // When
        let result = repository.fetch(ingredients, paging, sorting)
            .toBlocking()
            .materialize()
        
        // Then
        switch result {
            case .completed:
                XCTFail("result must not success." + getLocation())
            case .failed:
                break
        }
    }
    
    // MARK: - Save
    func test_PostRepository_savePostSuccess_shouldReturnRequestedPost() {
        // Given
        let repository = PostRepository(dataStore: dev.succeedPostDataStore)
        let post = DevInstances.generateRandomPost(id: 1)
        
        // When
        guard let result = try? repository.save(post)
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertEqual(result, post)
    }
    
    func test_PostRepository_savePostFailed_shouldReturnError() {
        // Given
        let repository = PostRepository(dataStore: dev.failPostDataStore)
        let post = DevInstances.generateRandomPost(id: 1)
        
        // When
        let result = repository.save(post)
            .toBlocking()
            .materialize()
        
        // Then
        switch result {
            case .completed:
                XCTFail("result must not success." + getLocation())
            case .failed:
                break
        }
    }
    
    // MARK: - Update
    func test_PostRepository_updatePostSuccess_shouldReturnUpdatedPost() {
        // Given
        let repository = PostRepository(dataStore: dev.succeedPostDataStore)
        let post = DevInstances.generateRandomPost(id: 1)
        
        // When
        guard let result = try? repository.update(post)
            .toBlocking()
            .first() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        // Then
        XCTAssertEqual(result, post)
    }
    
    func test_PostRepository_updatePostFailed_shouldReturnError() {
        // Given
        let repository = PostRepository(dataStore: dev.failPostDataStore)
        let post = DevInstances.generateRandomPost(id: 1)
        
        // When
        let result = repository.update(post)
            .toBlocking()
            .materialize()
        
        // Then
        switch result {
            case .completed:
                XCTFail("result must not success." + getLocation())
            case .failed:
                break
        }
    }
    
    // MARK: - Delete
    func test_PostRepository_deletePostSuccess_shouldReturnVoid() {
        // Given
        let repository = PostRepository(dataStore: dev.succeedPostDataStore)
        let post = DevInstances.generateRandomPost(id: 1)
        
        // When
        let result = repository.delete(post)
            .toBlocking()
            .materialize()
        
        // Then
        switch result {
            case .completed:
                break
            case .failed:
                XCTFail("result must not failed." + getLocation())
        }
    }
    
    func test_PostRepository_deletePostFailed_shouldReturnError() {
        // Given
        let repository = PostRepository(dataStore: dev.failPostDataStore)
        let post = DevInstances.generateRandomPost(id: 1)
        
        // When
        let result = repository.delete(post)
            .toBlocking()
            .materialize()
        
        // Then
        switch result {
            case .completed:
                XCTFail("result must not success." + getLocation())
            case .failed:
                break
        }
    }
}
