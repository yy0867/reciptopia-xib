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
    
    var profilePictureUrl: String? {
        return userSession.value?.account.profilePictureUrl
    }
    
    // MARK: - Methods
    init(
        userSession: BehaviorRelay<UserSession?>,
        makeNotSignedInMyPageViewModel: @escaping () -> NotSignedInMyPageViewModel,
        makeSignedInMyPageViewModel: @escaping (UserSession) -> SignedInMyPageViewModel
    ) {
        self.userSession = userSession
        self.makeNotSignedInMyPageViewModel = makeNotSignedInMyPageViewModel
        self.makeSignedInMyPageViewModel = makeSignedInMyPageViewModel
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
