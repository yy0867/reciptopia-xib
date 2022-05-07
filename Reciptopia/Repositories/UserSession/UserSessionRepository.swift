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
    
    // MARK: - Methods
    func signIn(credential: Credential) -> Observable<UserSession> {
        <#code#>
    }
    
    func signUp(credential: Credential, nickname: String) -> Observable<Account> {
        <#code#>
    }
    
    func readUserSession() -> Observable<UserSession> {
        <#code#>
    }
    
    func signOut() -> Observable<Void> {
        <#code#>
    }
    
    func isExists(email: String) -> Observable<Exist> {
        <#code#>
    }
    
    func withdrawal() -> Observable<Void> {
        <#code#>
    }
}
