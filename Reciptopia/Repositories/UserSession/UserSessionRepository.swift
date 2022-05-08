//
//  UserSessionRepository.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/07.
//

import Foundation
import RxSwift

final class UserSessionRepository: UserSessionRepositoryProtocol {
    
    // MARK: - Properties
    private let dataStore: TokenDataStoreProtocol
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
    
    // MARK: - Methods
    init(dataStore: TokenDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func signIn(credential: Credential) -> Observable<UserSession> {
        return .just(UserSession(
            token: "token",
            account: Account(
                id: 1,
                email: credential.email,
                password: nil,
                nickname: "nickname",
                profilePictureUrl: nil
            )
        ))
    }
    
    func signUp(credential: Credential, nickname: String) -> Observable<Account> {
        return .just(Account(
            id: 1,
            email: credential.email,
            password: nil,
            nickname: nickname,
            profilePictureUrl: nil
        ))
    }
    
    func rememberMe() -> Observable<UserSession?> {
        guard let token = dataStore.searchToken() else {
            return .just(nil)
        }
        
        return .just(fakeUserSession)
    }
    
    func signOut() -> Observable<Void> {
        if !dataStore.deleteToken() {
            return .error(ReciptopiaError.notFound)
        }
        
        return .just(())
    }
    
    func isExists(email: String) -> Observable<Exist> {
        return .just(Exist(isExists: Bool.random()))
    }
    
    func withdrawal() -> Observable<Void> {
        if !dataStore.deleteToken() {
            return .error(ReciptopiaError.notFound)
        }
        
        return .just(())
    }
}
