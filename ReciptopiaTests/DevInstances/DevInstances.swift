//
//  DevInstances.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/06.
//

import XCTest
import RxSwift
@testable import Reciptopia

extension XCTestCase {
    
    var dev: DevInstances {
        return DevInstances.shared
    }
}

struct DevInstances {
    
    static let shared = DevInstances()
}
