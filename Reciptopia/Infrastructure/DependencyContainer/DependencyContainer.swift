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
}
