//
//  FavoriteDataStoreProtocol.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation
import RxSwift

protocol FavoriteDataStoreProtocol {
    func fetch() -> Observable<[Favorite]>
    func save(_ favorite: Favorite) -> Observable<Favorite>
    func delete(_ favorite: Favorite) -> Observable<Void>
}
