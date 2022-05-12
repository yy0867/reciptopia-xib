//
//  SearchHistoryRepository.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation
import RxSwift

final class SearchHistoryRepository: SearchHistoryRepositoryProtocol {
    
    // MARK: - Properties
    private let dataStore: SearchHistoryDataStoreProtocol
    
    // MARK: - Methods
    init(dataStore: SearchHistoryDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetch() -> Observable<[SearchHistory]> {
        return dataStore.fetch()
    }
    
    func save(_ searchHistory: SearchHistory) -> Observable<SearchHistory> {
        return dataStore.save(searchHistory)
    }
    
    func update(_ searchHistory: SearchHistory) -> Observable<SearchHistory> {
        return dataStore.update(searchHistory)
    }
    
    func delete(_ searchHistory: SearchHistory) -> Observable<Void> {
        return dataStore.delete(searchHistory)
    }
}
