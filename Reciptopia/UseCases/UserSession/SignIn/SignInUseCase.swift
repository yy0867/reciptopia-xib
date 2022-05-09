//
//  SignInUseCase.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/08.
//

import Foundation
import RxSwift

final class SignInUseCase {
    
    // MARK: - Properties
    private let repository: UserSessionRepositoryProtocol
    
    // MARK: - Methods
    init(repository: UserSessionRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(email: String, password: String) -> Observable<UserSession> {
        let credential = Credential(email: email, password: password)
        return repository.signIn(credential: credential)
    }
}
