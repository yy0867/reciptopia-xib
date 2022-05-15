//
//  FavoriteViewModel.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/15.
//

import Foundation
import RxRelay
import RxSwift

final class FavoriteViewModel {
    
    // MARK: - Properties
    private let repository: FavoriteRepositoryProtocol
    private var subscription: Disposable?
    
    let favorites = BehaviorRelay<[Favorite]>(value: [])
    
    // MARK: - Methods
    init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetch() {
        
    }
    
    func save(post: Post) {
        
    }
    
    func delete(favorite: Favorite) {
        
    }
}
