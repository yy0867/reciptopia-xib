//
//  @Dependency.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/06.
//

import Foundation

@propertyWrapper
class Dependency<T> {
    
    let wrappedValue: T
    
    init() {
        self.wrappedValue = DependencyContainer.shared.resolve()
    }
}
