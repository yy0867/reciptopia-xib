//
//  SignedInMyPageViewModel.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation

final class SignedInMyPageViewModel {
    
    // MARK: - Properties
    private let userSession: UserSession
    
    // MARK: - Methods
    init(userSession: UserSession) {
        self.userSession = userSession
    }
}
