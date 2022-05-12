//
//  RealmSearchHistoryDataStore.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation
import RxSwift

final class RealmSearchHistoryDataStore: SearchHistoryDataStoreProtocol {
    
    // MARK: - Properties
    private let realmUtil = RealmUtil.shared
    
    // MARK: - Methods
    func fetch() -> Observable<[SearchHistory]> {
        let result = realmUtil
            .fetch(RealmSearchHistory.self)
            .map { $0.toModel() }
        
        return Observable.create { observer in
            observer.onNext(result)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func save(_ searchHistory: SearchHistory) -> Observable<SearchHistory> {
        var result: SearchHistory
        do {
            result = try realmUtil
                .save(entity: searchHistory.toEntity())
                .toModel()
        } catch {
            return Observable.error(error)
        }
        
        return Observable.create { observer in
            observer.onNext(result)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func update(_ searchHistory: SearchHistory) -> Observable<SearchHistory> {
        var result: SearchHistory
        do {
            result = try realmUtil.update(entity: searchHistory.toEntity()) { entity in
                entity.timestamp = Date.timestamp
            }
            .toModel()
        } catch {
            return Observable.error(error)
        }
        
        return Observable.create { observer in
            observer.onNext(result)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func delete(_ searchHistory: SearchHistory) -> Observable<Void> {
        do {
            try realmUtil.delete(entity: searchHistory.toEntity())
            
            return Observable.create { observer in
                observer.onNext(())
                observer.onCompleted()
                
                return Disposables.create()
            }
        } catch {
            return Observable.error(error)
        }
    }
}
