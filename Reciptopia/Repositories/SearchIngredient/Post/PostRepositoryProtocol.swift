//
//  PostRepositoryProtocol.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/23.
//

import Foundation
import RxSwift

protocol PostRepositoryProtocol {
    func fetch(_ ingredients: [Ingredient], _ page: Paging, _ sort: Sorting) -> Observable<[Post]>
    func save(_ post: Post) -> Observable<Post>
    func update(_ post: Post) -> Observable<Post>
    func delete(_ post: Post) -> Observable<Void>
}
