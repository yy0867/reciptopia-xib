//
//  SignInUseCases.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/09.
//

import Foundation

final class SignInUseCases {
    
    // MARK: - Properties
    let signInUseCase: SignInUseCase
    let rememberMeUseCase: RememberMeUseCase
    
    // MARK: - Methods
    init(repository: UserSessionRepositoryProtocol) {
        self.signInUseCase = SignInUseCase(repository: repository)
        self.rememberMeUseCase = RememberMeUseCase(repository: repository)
    }
}
