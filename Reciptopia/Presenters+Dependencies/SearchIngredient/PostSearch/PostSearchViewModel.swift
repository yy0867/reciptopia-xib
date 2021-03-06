//
//  PostSearchViewModel.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/23.
//

import Foundation
import RxRelay
import RxSwift

final class PostSearchViewModel {
    
    // MARK: - Properties
    let posts = BehaviorRelay<[Post]>(value: [])
    let isRefreshingPost = PublishRelay<Bool>()
    
    private let postRepository: PostRepositoryProtocol
    private let favoriteRepository: FavoriteRepositoryProtocol
    private var paging = Paging(page: 0)
    private let ingredients: [Ingredient]
    private var subscription: Disposable?
    
    // MARK: - Methods
    init(
        ingredients: [Ingredient],
        postRepository: PostRepositoryProtocol,
        favoriteRepository: FavoriteRepositoryProtocol
    ) {
        self.ingredients = ingredients
        self.postRepository = postRepository
        self.favoriteRepository = favoriteRepository
    }
    
    func fetch() {
        paging = Paging(page: 0)
        isRefreshingPost.accept(true)
        
        subscription = postRepository
            .fetch(ingredients, paging, Sorting(property: .id, order: .ascending))
            .subscribe(
                onNext: updatePost,
                onError: errorDetected,
                onDisposed: disposeSubscription
            )
    }
    
    func fetchNextPage() {
        paging.nextPage()
        
        subscription = postRepository
            .fetch(ingredients, paging, Sorting(property: .id, order: .ascending))
            .subscribe(
                onNext: appendPost,
                onError: errorDetected,
                onDisposed: disposeSubscription
            )
    }
    
    func toggleFavorite(at index: Int) {
        if posts.value[index].isFavorite {
            removeFavorite(at: index)
        } else {
            addFavorite(at: index)
        }
    }
    
    func addFavorite(at index: Int) {
        subscription = favoriteRepository.save(makeFavorite(byPost: posts.value[index]))
            .subscribe(
                onNext: { [weak self] _ in self?.updateIsFavorite(true, at: index) },
                onError: errorDetected,
                onDisposed: disposeSubscription
            )
    }
    
    func removeFavorite(at index: Int) {
        subscription = favoriteRepository.delete(makeFavorite(byPost: posts.value[index]))
            .subscribe(
                onNext: { [weak self] _ in self?.updateIsFavorite(false, at: index) },
                onError: errorDetected,
                onDisposed: disposeSubscription
            )
    }
    
    // MARK: - Private
    private func updatePost(_ receivedPosts: [Post]) {
        posts.accept(receivedPosts)
    }
    
    private func appendPost(_ receivedPosts: [Post]) {
        posts.append(contentsOf: receivedPosts)
    }
    
    private func makeFavorite(byPost post: Post) -> Favorite {
        return Favorite(postId: post.id ?? 0, title: post.title)
    }
    
    private func updateIsFavorite(_ isFavorite: Bool, at index: Int) {
        var mutablePosts = posts.value
        mutablePosts[index].isFavorite = isFavorite
        posts.accept(mutablePosts)
    }
    
    private func errorDetected(_ error: Error) {
        
    }
    
    private func disposeSubscription() {
        isRefreshingPost.accept(false)
        subscription?.dispose()
    }
}
