//
//  FavoriteRepositoryProtocol.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation
import RxSwift
import RxRelay

protocol FavoriteRepositoryProtocol {
    
    var dataStore: BehaviorRelay<FavoriteDataStoreProtocol> { get }
    
    func fetch() -> Observable<[Favorite]>
    func save(_ favorite: Favorite) -> Observable<Favorite>
    func delete(_ favorite: Favorite) -> Observable<Void>
}
