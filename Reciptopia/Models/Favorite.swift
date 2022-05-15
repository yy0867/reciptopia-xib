//
//  Favorite.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation

struct Favorite {
    let id: Int?
    let postId: Int
    let title: String
    
    init(id: Int? = nil, postId: Int, title: String) {
        self.id = id
        self.postId = postId
        self.title = title
    }
}

extension Favorite: Identifiable, Equatable {}
