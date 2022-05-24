//
//  PostDataStore.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/24.
//

import Foundation
import RxSwift

final class PostDataStore: PostDataStoreProtocol {
    
    // MARK: - Properties
    private var posts = [Post]()
    
    // MARK: - Methods
    init() {
        for i in 1...60 {
            posts.append(
                Post(
                    id: i,
                    ownerId: i,
                    title: "Post Title \(i)",
                    content: "Post Content \(i)",
                    pictureUrls: [String](repeating: "https://www.example.com", count: 10),
                    views: Int.random(in: 1...1000000),
                    isFavorite: Bool.random()
                )
            )
        }
    }
    
    func fetch(_ dto: PostDTO.Search) -> Observable<[Post]> {
        let page = dto.paging.page
        let size = dto.paging.size
        
        if (page + 1) * size >= 60 { return .just([]) }
        
        let post = Array(posts[(page * size)..<((page + 1) * size)])
        return .just(post)
    }
    
    func save(_ post: Post) -> Observable<Post> {
        posts.append(post)
        return .just(post)
    }
    
    func update(_ post: Post) -> Observable<Post> {
        guard let index = posts.firstIndex(where: { $0.id == post.id }) else {
            return .error(ReciptopiaError.notFound)
        }
        posts[index] = post
        return .just(post)
    }
    
    func delete(_ post: Post) -> Observable<Void> {
        guard let index = posts.firstIndex(where: { $0.id == post.id }) else {
            return .error(ReciptopiaError.notFound)
        }
        posts.remove(at: index)
        return .just(())
    }
}
