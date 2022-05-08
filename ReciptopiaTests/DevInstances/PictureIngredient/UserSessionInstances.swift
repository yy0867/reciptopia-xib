//
//  UserSessionInstances.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/07.
//

import Foundation
import RxSwift
@testable import Reciptopia

// MARK: - UserSession
extension DevInstances {
    
    class FakeTokenDataStore: TokenDataStoreProtocol {
        
        var isSucceedCase: Bool
        
        init(isSucceedCase: Bool = true) {
            self.isSucceedCase = isSucceedCase
        }
        
        func addToken(_ token: String) -> Bool {
            return isSucceedCase
        }
        
        /// if `isSucceedCase` is `true`, it returns "token"
        /// else, it returns `nil`.
        func searchToken() -> String? {
            if isSucceedCase { return "token" }
            else { return nil }
        }
        
        func updateToken(_ token: String) -> Bool {
            return isSucceedCase
        }
        
        func deleteToken() -> Bool {
            return isSucceedCase
        }
    }
}

