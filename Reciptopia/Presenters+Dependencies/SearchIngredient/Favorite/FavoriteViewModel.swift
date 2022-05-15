//
//  FavoriteViewModel.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/15.
//

import Foundation
import RxRelay
import RxSwift

final class FavoriteViewModel {
    
    enum State {
        case none
        case loading
        case complete
        case errorDetected
    }
    
    // MARK: - Properties
    private let repository: FavoriteRepositoryProtocol
    private var subscription: Disposable?
    
    let favorites = BehaviorRelay<[Favorite]>(value: [])
    let state = BehaviorRelay<State>(value: .none)
    
    // MARK: - Methods
    init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetch() {
        subscription = repository.fetch()
            .subscribe(
                onNext: updateFavorites,
                onError: handleError,
                onDisposed: disposeSubscription
            )
    }
    
    func save(post: Post) {
        guard let postId = post.id else { return }
        let favorite = Favorite(postId: postId, title: post.title)
        
        subscription = repository.save(favorite)
            .subscribe(
                onNext: { [weak self] _ in self?.fetch() },
                onError: handleError,
                onDisposed: disposeSubscription
            )
    }
    
    func delete(_ favorite: Favorite) {
        subscription = repository.delete(favorite)
            .subscribe(
                onNext: { [weak self] _ in self?.fetch() },
                onError: handleError,
                onDisposed: disposeSubscription
            )
    }
    
    // MARK: - Privates
    private func updateFavorites(by favorites: [Favorite]) {
        self.state.accept(.complete)
        self.favorites.accept(favorites)
    }
    
    private func handleError(_ error: Error) {
        state.accept(.errorDetected)
    }
    
    private func disposeSubscription() {
        self.state.accept(.complete)
        self.subscription?.dispose()
    }
}
