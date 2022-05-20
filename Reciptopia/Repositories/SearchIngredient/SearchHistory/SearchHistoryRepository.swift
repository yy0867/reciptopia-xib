//
//  SearchHistoryRepository.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation
import RxSwift
import RxRelay

final class SearchHistoryRepository: SearchHistoryRepositoryProtocol {
    
    // MARK: - Properties
    private let dataStore: BehaviorRelay<SearchHistoryDataStoreProtocol>
    
    // MARK: - Methods
    init(dataStore: BehaviorRelay<SearchHistoryDataStoreProtocol>) {
        self.dataStore = dataStore
    }
    
    func fetch() -> Observable<[SearchHistory]> {
        return dataStore.value.fetch()
    }
    
    func save(_ searchHistory: SearchHistory) -> Observable<SearchHistory> {
        return dataStore.value.save(searchHistory)
    }
    
    func update(_ searchHistory: SearchHistory) -> Observable<SearchHistory> {
        return dataStore.value.update(searchHistory)
    }
    
    func delete(_ searchHistory: SearchHistory) -> Observable<Void> {
        return dataStore.value.delete(searchHistory)
    }
}
