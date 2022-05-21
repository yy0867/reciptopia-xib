//
//  SearchHistoryViewModel.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/14.
//

import Foundation
import RxRelay
import RxSwift

final class SearchHistoryViewModel {
    
    enum State {
        case none
        case loading
        case complete
        case errorDetected
    }
    
    // MARK: - Properties
    private let repository: SearchHistoryRepositoryProtocol
    private var subscription: Disposable?
    
    let histories = BehaviorRelay<[SearchHistory]>(value: [])
    let state = BehaviorRelay<State>(value: .none)
    
    // MARK: - Methods
    init(repository: SearchHistoryRepositoryProtocol) {
        self.repository = repository
        
        fetch()
    }
    
    func fetch() {
        state.accept(.loading)
        subscription = repository.fetch()
            .subscribe(
                onNext: updateHistories,
                onError: handleError,
                onDisposed: disposeSubscription
            )
    }
    
    func save(_ ingredients: [Ingredient]) {
        let history = SearchHistory(ingredients: ingredients, timestamp: Date.timestamp)
        subscription = repository.save(history)
            .subscribe(
                onNext: { [weak self] _ in self?.fetch() },
                onError: handleError,
                onDisposed: disposeSubscription
            )
    }
    
    func update(at index: Int) {
        let history = histories.value[index]
        let updatedHistory = SearchHistory(
            id: history.id,
            ingredients: history.ingredients,
            timestamp: Date.timestamp
        )
        subscription = repository.update(updatedHistory)
            .subscribe(
                onNext: { [weak self] _ in self?.fetch() },
                onError: handleError,
                onDisposed: disposeSubscription
            )
    }
    
    func delete(at index: Int) {
        let history = histories.value[index]
        subscription = repository.delete(history)
            .subscribe(
                onNext: { [weak self] _ in self?.fetch() },
                onError: handleError,
                onDisposed: disposeSubscription
            )
    }
    
    // MARK: - Privates
    private func updateHistories(by histories: [SearchHistory]) {
        self.state.accept(.complete)
        self.histories.accept(histories)
    }
    
    private func handleError(_ error: Error) {
        state.accept(.errorDetected)
    }
    
    private func disposeSubscription() {
        self.state.accept(.complete)
        self.subscription?.dispose()
    }
}
