//
//  RealmFavoriteDataStore.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation
import Realm
import RealmSwift
import RxSwift

final class RealmFavoriteDataStore: FavoriteDataStoreProtocol {
    
    // MARK: - Properties
    private let realmUtil = RealmUtil.shared
    
    // MARK: - Methods
    func fetch() -> Observable<[Favorite]> {
        let result = realmUtil
            .fetch(RealmFavorite.self)
            .map { $0.toModel() }
        
        return Observable.create { observer in
            observer.onNext(result)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func save(_ favorite: Favorite) -> Observable<Favorite> {
        var result: Favorite
        do {
            result = try realmUtil
                .save(entity: favorite.toEntity())
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
    
    func delete(_ favorite: Favorite) -> Observable<Void> {
        do {
            try realmUtil.delete(entity: favorite.toEntity())
            
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
