//
//  RealmIdentifiable.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/21.
//

import Foundation
import Realm
import RealmSwift

protocol RealmIdentifiable: Object & Identifiable {
    var id: Int { get set }
    func setToNextId()
}

extension RealmIdentifiable {
    func setToNextId() {
        if let lastObject = RealmUtil.shared.fetch(Self.self).last {
            id = lastObject.id + 1
        } else {
            Log.print("RealmUtil.fetch can't find last object -> id set to 1.")
        }
    }
}
