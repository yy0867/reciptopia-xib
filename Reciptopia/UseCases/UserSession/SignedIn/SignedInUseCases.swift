//
//  SignedInUseCases.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/09.
//

import Foundation

final class SignedInUseCases {
    
    // MARK: - Properties
    let withdrawalUseCase: WithdrawalUseCase
    let signOutUseCase: SignOutUseCase
    
    // MARK: - Methods
    init(repository: UserSessionRepositoryProtocol) {
        self.withdrawalUseCase = WithdrawalUseCase(repository: repository)
        self.signOutUseCase = SignOutUseCase(repository: repository)
    }
}
