//
//  FavoriteRepository.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation
import RxSwift
import RxRelay

final class FavoriteRepository: FavoriteRepositoryProtocol {
    
    // MARK: - Properties
    private let dataStore: BehaviorRelay<FavoriteDataStoreProtocol>
    
    // MARK: - Methods
    init(dataStore: BehaviorRelay<FavoriteDataStoreProtocol>) {
        self.dataStore = dataStore
    }
    
    func fetch() -> Observable<[Favorite]> {
        return dataStore.value.fetch()
    }
    
    func save(_ favorite: Favorite) -> Observable<Favorite> {
        return dataStore.value.save(favorite)
    }
    
    func delete(_ favorite: Favorite) -> Observable<Void> {
        return dataStore.value.delete(favorite)
    }
}
