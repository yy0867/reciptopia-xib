//
//  SignUpUseCase.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/08.
//

import Foundation
import RxSwift

final class SignUpUseCase {
    
    // MARK: - Properties
    private let repository: UserSessionRepositoryProtocol
    
    // MARK: - Methods
    init(repository: UserSessionRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(email: String, password: String, nickname: String) -> Observable<Account> {
        let credential = Credential(email: email, password: password)
        return repository.signUp(credential: credential, nickname: nickname)
    }
}
