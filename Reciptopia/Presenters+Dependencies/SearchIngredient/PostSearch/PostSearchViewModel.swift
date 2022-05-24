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
        fetch(with: paging)
    }
    
    func fetchNextPage() {
        paging.nextPage()
        fetch(with: paging)
    }
    
    func addFavorite(at index: Int) {
        let post = posts.value[index]
        guard let postId = post.id else { return }
        let favorite = Favorite(postId: postId, title: post.title)
        
        subscription = favoriteRepository.save(favorite)
            .subscribe(
                onError: errorDetected,
                onCompleted: fetchFavoriteAndUpdatePosts,
                onDisposed: disposeSubscription
            )
    }
    
    func removeFavorite(at index: Int) {
        
    }
    
    // MARK: - Private
    private func fetch(with paging: Paging) {
        subscription = postRepository
            .fetch(ingredients, paging, Sorting(property: .id, order: .ascending))
            .subscribe(
                onNext: updatePost,
                onError: errorDetected,
                onDisposed: disposeSubscription
            )
    }
    
    private func updatePost(_ receivedPosts: [Post]) {
        posts.accept(receivedPosts)
    }
    
    private func fetchFavoriteAndUpdatePosts() {
        subscription = favoriteRepository.fetch()
            .map(mapFavoriteAndPost)
            .subscribe(
                onNext: updatePost,
                onError: errorDetected,
                onDisposed: disposeSubscription
            )
    }
    
    private func mapFavoriteAndPost(_ favorites: [Favorite]) -> [Post] {
        var dict = [Int: Bool]()
        var mutablePosts = [Post]()
        for favorite in favorites {
            dict[favorite.postId] = true
        }
        for postId in dict.keys {
            if let index = mutablePosts.firstIndex(where: { $0.id == postId }) {
                mutablePosts[index].isFavorite = true
            }
        }
        return mutablePosts
    }
    
    private func errorDetected(_ error: Error) {
        
    }
    
    private func disposeSubscription() {
        subscription?.dispose()
    }
}
