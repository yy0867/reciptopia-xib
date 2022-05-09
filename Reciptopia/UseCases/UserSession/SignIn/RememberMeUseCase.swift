//
//  RememberMeUseCase.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/08.
//

import Foundation
import RxSwift

final class RememberMeUseCase {
    
    // MARK: - Properties
    private let repository: UserSessionRepositoryProtocol
    
    // MARK: - Methods
    init(repository: UserSessionRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> Observable<UserSession?> {
        return repository.rememberMe()
    }
}
