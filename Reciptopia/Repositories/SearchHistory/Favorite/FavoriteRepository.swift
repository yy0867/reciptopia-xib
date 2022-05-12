//
//  FavoriteRepository.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation
import RxSwift

final class FavoriteRepository: FavoriteRepositoryProtocol {
    
    // MARK: - Properties
    private let dataStore: FavoriteDataStoreProtocol
    
    // MARK: - Methods
    init(dataStore: FavoriteDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetch() -> Observable<[Favorite]> {
        return dataStore.fetch()
    }
    
    func save(_ favorite: Favorite) -> Observable<Favorite> {
        return dataStore.save(favorite)
    }
    
    func delete(_ favorite: Favorite) -> Observable<Void> {
        return dataStore.delete(favorite)
    }
}
