//
//  Post.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/15.
//

import Foundation

struct Post {
    let id: Int?
    let ownerId: Int
    let title: String
    let content: String
    let pictureUrls: [String]
    let views: Int
    let likeTags: Int
    let comments: Int
    var isFavorite: Bool
    
    init(
        id: Int? = nil,
        ownerId: Int,
        title: String,
        content: String,
        pictureUrls: [String],
        views: Int = 0,
        isFavorite: Bool = false
    ) {
        self.id = id
        self.ownerId = ownerId
        self.title = title
        self.content = content
        self.pictureUrls = pictureUrls
        self.views = views
        self.likeTags = 0
        self.comments = 0
        self.isFavorite = isFavorite
    }
}

extension Post: Equatable {}
