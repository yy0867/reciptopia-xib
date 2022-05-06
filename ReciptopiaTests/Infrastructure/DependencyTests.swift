//
//  DependencyTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/06.
//

import XCTest
@testable import Reciptopia

#if DEBUG
// MARK: - Fake Protocol + Class
protocol FakeProtocol {
    var description: String { get }
}

class FakeClass: FakeProtocol {
    let description: String
    
    init(description: String) {
        self.description = description
    }
}
#endif

// MARK: - Test
class DependencyTests: XCTestCase {
    
    override func setUp() {
        
    }
    
    func test_DependencyContainer_registerInstance_shouldResolveInstance() {
        // Given
        let fakeInstance = FakeClass(description: "Fake Instance of Fake Class")
        
        // When
        DependencyContainer.shared.register(FakeProtocol.self) { _ in
            return fakeInstance
        }
        
        // Then
        guard let resolvedInstance: FakeProtocol = DependencyContainer.shared.resolve() else {
            XCTFail("\(#function) \(#line) fails.")
            return
        }
        
        XCTAssertEqual(resolvedInstance.description, fakeInstance.description)
    }
    
    func test_DependencyContainer_remove_shouldRemoveInstance() {
        // Given
        let fakeInstance = FakeClass(description: "Fake Instance of Fake Class")
        DependencyContainer.shared.register(FakeProtocol.self) { _ in
            return fakeInstance
        }
        
        // When
        DependencyContainer.shared.remove(of: FakeProtocol.self)
        
        // Then
        let nilInstance: FakeProtocol? = DependencyContainer.shared.resolve()
        XCTAssertNil(nilInstance)
    }
}
