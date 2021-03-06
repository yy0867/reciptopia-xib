//
//  MyPageViewControllerProviderTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/12.
//

import XCTest
@testable import Reciptopia

class MyPageViewControllerProviderTests: XCTestCase {
    
    var container: RootDIContainer!
    var myPageProvider: MyPageViewControllerProvider!
    
    override func setUp() {
        self.container = RootDIContainer()
        self.myPageProvider = MyPageViewControllerProvider(
            userSession: container.userSession,
            makeNotSignedInMyPageViewModel: { return NotSignedInMyPageViewModel() },
            makeSignedInMyPageViewModel: { userSession in
                return SignedInMyPageViewModel(userSession: userSession)
            }
        )
    }
    
    func test_MyPageProvider_ifUserSessionNil_shouldReturnNotSignedInMyPageViewController() {
        // Given
        container.userSession.accept(nil)
        
        // When
        let returnedVC = myPageProvider.makeMyPageViewController()
        let profilePictureUrl = myPageProvider.profilePictureUrl
        
        // Then
        XCTAssert(returnedVC is NotSignedInMyPageViewController)
        XCTAssertNil(profilePictureUrl)
    }
    
    func test_MyPageProvider_ifUserSessionExist_shouldReturnSignedInMyPageViewController() {
        // Given
        let fakeUserSession = UserSession(token: "token", account: dev.fakeAccount)
        container.userSession.accept(fakeUserSession)
        
        // When
        let returnedVC = myPageProvider.makeMyPageViewController()
        let profilePictureUrl = myPageProvider.profilePictureUrl
        
        // Then
        XCTAssert(returnedVC is SignedInMyPageViewController)
        XCTAssertEqual(profilePictureUrl, dev.fakeAccount.profilePictureUrl)
    }
}
