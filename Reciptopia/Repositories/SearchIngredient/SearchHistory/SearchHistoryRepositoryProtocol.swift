//
//  SearchHistoryRepositoryProtocol.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation
import RxSwift
import RxRelay

protocol SearchHistoryRepositoryProtocol {
    
    var dataStore: BehaviorRelay<SearchHistoryDataStoreProtocol> { get }
    
    func fetch() -> Observable<[SearchHistory]>
    func save(_ searchHistory: SearchHistory) -> Observable<SearchHistory>
    func update(_ searchHistory: SearchHistory) -> Observable<SearchHistory>
    func delete(_ searchHistory: SearchHistory) -> Observable<Void>
}
