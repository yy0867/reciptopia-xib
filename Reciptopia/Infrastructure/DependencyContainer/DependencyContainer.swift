//
//  DependencyContainer.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/06.
//

import Foundation

class DependencyContainer {
    
    static let shared = DependencyContainer()
    private var dependencies = [String: Any]()
    private init() {}
    
    private func makeKey<T>(of type: T.Type) -> String {
        return String(describing: type.self)
    }
    
    func register<T>(_ type: T.Type, _ instance: (DependencyContainer) -> T) {
        let key = makeKey(of: type)
        let instance = instance(DependencyContainer.shared)
        
        dependencies.updateValue(instance, forKey: key)
    }
    
    func resolve<T>() -> T {
        let key = makeKey(of: T.self)
        
        guard let instance = dependencies[key] as? T else {
            fatalError("Fail to get \(key)'s instance.")
        }
        
        return instance
    }
}
