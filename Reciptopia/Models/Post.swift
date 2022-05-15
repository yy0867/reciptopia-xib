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
    
    init(
        id: Int? = nil,
        ownerId: Int,
        title: String,
        content: String,
        pictureUrls: [String],
        views: Int
    ) {
        self.id = id
        self.ownerId = ownerId
        self.title = title
        self.content = content
        self.pictureUrls = pictureUrls
        self.views = views
    }
}
