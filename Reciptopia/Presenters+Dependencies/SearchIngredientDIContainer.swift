//
//  SearchIngredientDIContainer.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/20.
//

import Foundation
import RxSwift
import RxRelay

final class SearchIngredientDIContainer {
    
    // MARK: - Long Lived
    private var searchHistoryRepository: SearchHistoryRepositoryProtocol!
    private var favoriteRepository: FavoriteRepositoryProtocol!
    private let disposeBag = DisposeBag()
    
    init(userSession: BehaviorRelay<UserSession?>) {
        
        // MARK: Search History
        func bindSearchHistoryDataStoreByUserSessionState() {
            userSession
                .map(makeSearchHistoryDataStore)
                .bind(to: searchHistoryRepository.dataStore)
                .disposed(by: disposeBag)
        }
        
        func makeSearchHistoryDataStore(
            by userSession: UserSession?
        ) -> SearchHistoryDataStoreProtocol {
            switch userSession {
                case .none:
                    return makeLocalSearchHistoryDataStore()
                case .some(let userSession):
                    return makeRemoteSearchHistoryDataStore(userSession: userSession)
            }
        }
        
        func makeLocalSearchHistoryDataStore() -> SearchHistoryDataStoreProtocol {
            return RealmSearchHistoryDataStore()
        }
        
        func makeRemoteSearchHistoryDataStore(
            userSession: UserSession
        ) -> SearchHistoryDataStoreProtocol {
            return RealmSearchHistoryDataStore()
        }
        
        // MARK: Favorite
        func bindFavoriteDataStoreByUserSessionState() {
            userSession
                .map(makeFavoriteDataStore)
                .bind(to: favoriteRepository.dataStore)
                .disposed(by: disposeBag)
        }
        
        func makeFavoriteDataStore(by userSession: UserSession?) -> FavoriteDataStoreProtocol {
            switch userSession {
                case .none:
                    return makeLocalFavoriteDataStore()
                case .some(let userSession):
                    return makeRemoteFavoriteDataStore(userSession: userSession)
            }
        }
        
        func makeLocalFavoriteDataStore() -> FavoriteDataStoreProtocol {
            return RealmFavoriteDataStore()
        }
        
        func makeRemoteFavoriteDataStore(userSession: UserSession) -> FavoriteDataStoreProtocol {
            return RealmFavoriteDataStore()
        }
        
        // MARK: Initialize
        self.searchHistoryRepository = SearchHistoryRepository(
            dataStore: BehaviorRelay(value: makeLocalSearchHistoryDataStore())
        )
        self.favoriteRepository = FavoriteRepository(
            dataStore: BehaviorRelay(value: makeLocalFavoriteDataStore())
        )
        
        bindSearchHistoryDataStoreByUserSessionState()
        bindFavoriteDataStoreByUserSessionState()
    }
    
    // MARK: - Factories
    func makeSearchIngredientViewController() -> SearchIngredientViewController {
        let searchIngredientViewModel = makeSearchIngredientViewModel()
        let searchHistoryViewModel = makeSearchHistoryViewModel()
        let favoriteViewModel = makeFavoriteViewModel()
        
        return SearchIngredientViewController.create(
            searchIngredientViewModel: searchIngredientViewModel,
            searchHistoryViewModel: searchHistoryViewModel,
            favoriteViewModel: favoriteViewModel,
            postSearchViewControllerFactory: makePostSearchViewController
        )
    }
    
    func makeSearchIngredientViewModel() -> SearchIngredientViewModel {
        return SearchIngredientViewModel()
    }
    
    func makeSearchHistoryViewModel() -> SearchHistoryViewModel {
        return SearchHistoryViewModel(repository: self.searchHistoryRepository)
    }
    
    func makeFavoriteViewModel() -> FavoriteViewModel {
        return FavoriteViewModel(repository: self.favoriteRepository)
    }
    
    // MARK: - Post Search
    func makePostSearchViewController(with ingredients: [Ingredient]) -> PostSearchViewController {
        let viewModel = makePostSearchViewModel(with: ingredients)
        return PostSearchViewController.create(with: viewModel)
    }
    
    func makePostSearchViewModel(with ingredients: [Ingredient]) -> PostSearchViewModel {
        let postRepository = makePostRepository()
        
        return PostSearchViewModel(
            ingredients: ingredients,
            postRepository: postRepository,
            favoriteRepository: favoriteRepository
        )
    }
    
    func makePostRepository() -> PostRepositoryProtocol {
        let dataStore = makePostDataStore()
        return PostRepository(dataStore: dataStore)
    }
    
    func makePostDataStore() -> PostDataStoreProtocol {
        return PostDataStore()
    }
}
