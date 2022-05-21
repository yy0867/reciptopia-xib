//
//  RealmFavorite+Mapping.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation
import Realm
import RealmSwift

class RealmFavorite: Object, RealmIdentifiable {
    
    @Persisted(primaryKey: true)
    var id: Int = 0
    
    @Persisted
    var postId: Int = 0
    
    @Persisted
    var title: String = ""
    
    convenience init(id: Int, postId: Int, title: String) {
        self.init()
        self.id = id
        self.postId = postId
        self.title = title
    }
}

extension Favorite {
    func toEntity() -> RealmFavorite {
        return RealmFavorite(
            id: id ?? 0,
            postId: postId,
            title: title
        )
    }
}

extension RealmFavorite {
    func toModel() -> Favorite {
        return Favorite(
            id: id,
            postId: postId,
            title: title
        )
    }
}
