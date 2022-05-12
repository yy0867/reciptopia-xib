//
//  MyPageViewControllerProvider.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import Foundation
import RxSwift
import RxRelay

final class MyPageViewControllerProvider {
    
    // MARK: - Properties
    private let userSession: BehaviorRelay<UserSession?>
    private let makeNotSignedInMyPageViewModel: () -> NotSignedInMyPageViewModel
    private let makeSignedInMyPageViewModel: (UserSession) -> SignedInMyPageViewModel
    
    // MARK: - Methods
    init(userSession: BehaviorRelay<UserSession?>) {
        self.userSession = userSession
    }
    
    func makeMyPageViewController() -> MyPageViewControllerProtocol {
        switch userSession.value {
            case .none:
                let viewModel = makeNotSignedInMyPageViewModel()
                return NotSignedInMyPageViewController.create(with: viewModel)
            case .some(let userSession):
                let viewModel = makeSignedInMyPageViewModel(userSession)
                return SignedInMyPageViewController.create(with: viewModel)
        }
    }
}
