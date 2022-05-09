//
//  SignUpUseCases.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/09.
//

import Foundation

final class SignUpUseCases {
    
    // MARK: - Properties
    let signUpUseCase: SignUpUseCase
    let checkEmailExistsUseCase: CheckEmailExistsUseCase
    
    // MARK: - Methods
    init(repository: UserSessionRepositoryProtocol) {
        self.signUpUseCase = SignUpUseCase(repository: repository)
        self.checkEmailExistsUseCase = CheckEmailExistsUseCase(repository: repository)
    }
}
