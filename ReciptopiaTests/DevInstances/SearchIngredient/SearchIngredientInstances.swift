//
//  SearchIngredientInstances.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation
import RxSwift
@testable import Reciptopia

extension DevInstances {
    
    class FakeSearchHistoryDataStore: SearchHistoryDataStoreProtocol {
        
        var searchHistories = [SearchHistory]()
        
        func fetch() -> Observable<[SearchHistory]> {
            return Observable.create { [weak self] observer in
                guard let self = self else {
                    observer.onError(ReciptopiaError.unknown)
                    return Disposables.create()
                }
                observer.onNext(self.searchHistories)
                observer.onCompleted()
                
                return Disposables.create()
            }
        }
        
        func save(_ searchHistory: SearchHistory) -> Observable<SearchHistory> {
            searchHistories.append(searchHistory)
            return Observable.create { observer in
                observer.onNext(searchHistory)
                observer.onCompleted()
                
                return Disposables.create()
            }
        }
        
        func update(_ searchHistory: SearchHistory) -> Observable<SearchHistory> {
            guard let index = searchHistories.firstIndex(where: { $0.id == searchHistory.id }) else {
                return Observable.error(ReciptopiaError.notFound)
            }
            searchHistories[index] = searchHistory
            
            return Observable.create { observer in
                observer.onNext(searchHistory)
                observer.onCompleted()
                
                return Disposables.create()
            }
        }
        
        func delete(_ searchHistory: SearchHistory) -> Observable<Void> {
            guard let index = searchHistories.firstIndex(where: { $0.id == searchHistory.id }) else {
                return Observable.error(ReciptopiaError.unknown)
            }
            searchHistories.remove(at: index)
            
            return Observable.create { observer in
                observer.onNext(())
                observer.onCompleted()
                
                return Disposables.create()
            }
        }
    }
    
    class FakeFavoriteDataStore: FavoriteDataStoreProtocol {
        
        var favorites = [Favorite]()
        
        func fetch() -> Observable<[Favorite]> {
            return Observable.create { [weak self] observer in
                guard let self = self else {
                    observer.onError(ReciptopiaError.unknown)
                    return Disposables.create()
                }
                observer.onNext(self.favorites)
                observer.onCompleted()
                
                return Disposables.create()
            }
        }
        
        func save(_ favorite: Favorite) -> Observable<Favorite> {
            favorites.append(favorite)
            return Observable.create { observer in
                observer.onNext(favorite)
                observer.onCompleted()
                
                return Disposables.create()
            }
        }
        
        func update(_ favorite: Favorite) -> Observable<Favorite> {
            guard let index = favorites.firstIndex(where: { $0.id == favorite.id }) else {
                return Observable.error(ReciptopiaError.notFound)
            }
            favorites[index] = favorite
            
            return Observable.create { observer in
                observer.onNext(favorite)
                observer.onCompleted()
                
                return Disposables.create()
            }
        }
        
        func delete(_ favorite: Favorite) -> Observable<Void> {
            guard let index = favorites.firstIndex(where: { $0.id == favorite.id }) else {
                return Observable.error(ReciptopiaError.unknown)
            }
            favorites.remove(at: index)
            
            return Observable.create { observer in
                observer.onNext(())
                observer.onCompleted()
                
                return Disposables.create()
            }
        }
    }
}
