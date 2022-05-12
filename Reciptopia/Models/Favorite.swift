//
//  Favorite.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation

struct Favorite {
    let id: Int?
    let postId: Int?
    let title: String
}

extension Favorite: Identifiable, Equatable {}
