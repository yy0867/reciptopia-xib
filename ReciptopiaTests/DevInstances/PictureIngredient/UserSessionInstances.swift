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
    
    class FakeUserSessionRepository: UserSessionRepositoryProtocol {
        
        let isSucceedCase: Bool
        private let fakeUserSession: UserSession = UserSession(
            token: "token",
            account: Account(
                id: 1,
                email: "email@example.com",
                password: nil,
                nickname: "nickname",
                profilePictureUrl: "https://www.example.com"
            )
        )
        
        init(isSucceedCase: Bool = true) {
            self.isSucceedCase = isSucceedCase
        }
        
        func signIn(credential: Credential) -> Observable<UserSession> {
            if isSucceedCase {
                return .just(UserSession(token: "token", account: Account(
                    id: 1,
                    email: credential.email,
                    password: nil,
                    nickname: "nickname",
                    profilePictureUrl: "https://www.example.com"
                )))
            } else {
                return .error(ReciptopiaError.signInFail)
            }
        }
        
        func signUp(credential: Credential, nickname: String) -> Observable<Account> {
            if isSucceedCase {
                return .just(Account(
                    id: 1,
                    email: credential.email,
                    password: nil,
                    nickname: nickname,
                    profilePictureUrl: nil)
                )
            } else {
                return .error(NetworkError.unknown)
            }
        }
        
        func rememberMe() -> Observable<UserSession?> {
            if isSucceedCase {
                return .just(fakeUserSession)
            } else {
                return .just(nil)
            }
        }
        
        func signOut() -> Observable<Void> {
            if isSucceedCase {
                return .just(())
            } else {
                return .error(ReciptopiaError.unknown)
            }
        }
        
        func isExists(email: String) -> Observable<Exist> {
            if isSucceedCase {
                return .just(Exist(isExists: false))
            } else {
                return .just(Exist(isExists: true))
            }
        }
        
        func withdrawal() -> Observable<Void> {
            if isSucceedCase {
                return .just(())
            } else {
                return .error(ReciptopiaError.unknown)
            }
        }
    }
    
    class FakeTokenDataStore: TokenDataStoreProtocol {
        
        let isSucceedCase: Bool
        
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

