//
//  UserSessionRepositoryProtocol.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/07.
//

import Foundation
import RxSwift

protocol UserSessionRepositoryProtocol {
    func signIn(credential: Credential) -> Observable<UserSession>
    func signUp(credential: Credential, nickname: String) -> Observable<Account>
    func rememberMe() -> Observable<UserSession?>
    func signOut() -> Observable<Void>
    func isExists(email: String) -> Observable<Exist>
    func withdrawal() -> Observable<Void>
}
