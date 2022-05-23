//
//  PostRepository.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/23.
//

import Foundation
import RxSwift

final class PostRepository: PostRepositoryProtocol {
    
    // MARK: - Properties
    private let dataStore: PostDataStoreProtocol
    
    // MARK: - Methods
    init(dataStore: PostDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetch(_ ingredients: [Ingredient], _ page: Paging, _ sort: Sorting) -> Observable<[Post]> {
        let dto = PostDTO.Search(ingredients: ingredients, sorting: sort, paging: page)
        
        return dataStore.fetch(dto)
    }
    
    func save(_ post: Post) -> Observable<Post> {
        return dataStore.save(post)
    }
    
    func update(_ post: Post) -> Observable<Post> {
        return dataStore.update(post)
    }
    
    func delete(_ post: Post) -> Observable<Void> {
        return dataStore.delete(post)
    }
}
