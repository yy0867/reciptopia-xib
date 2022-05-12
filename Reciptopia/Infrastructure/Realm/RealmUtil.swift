//
//  RealmUtil.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation
import Realm
import RealmSwift

final class RealmUtil {
    
    // MARK: - Properties
    static let shared = RealmUtil()
    private let realm: Realm?
    
    // MARK: - Methods
    private init() {
        self.realm = try? Realm()
    }
    
    func fetch<Entity>(_ type: Entity.Type) -> [Entity] where Entity: Object {
        guard let realm = realm else { return [] }
        
        let result = realm.objects(type.self)
        return Array(result)
    }
    
    func save<Entity>(entity: Entity) throws -> Entity where Entity: Object {
        guard let realm = realm else { throw ReciptopiaError.notFound }
        
        try realm.write { realm.add(entity) }
    }
    
    func update<Entity>(
        entity: Entity,
        perform updateAction: (Entity) -> Void
    ) throws -> Entity where Entity: Object & Identifiable {
        guard let realm = realm,
              let entityToUpdate = fetch(Entity.self).first(where: { $0.id == entity.id }) else {
            throw ReciptopiaError.notFound
        }
        
        try realm.write { updateAction(entityToUpdate) }
    }
    
    func delete<Entity>(entity: Entity) throws where Entity: Object & Identifiable {
        guard let realm = realm,
              let entityToDelete = fetch(Entity.self).first(where: { $0.id == entity.id }) else {
            throw ReciptopiaError.notFound
        }
        
        try realm.write { realm.delete(entityToDelete) }
    }
}
