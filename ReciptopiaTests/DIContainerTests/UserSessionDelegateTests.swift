//
//  UserSessionDelegateTests.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/11.
//

import XCTest
import RxBlocking
import RxTest
import RxSwift
@testable import Reciptopia

class UserSessionDelegateTests: XCTestCase {
    
    class FakeUserSessionResponder {
        weak var userSessionDelegate: UserSessionDelegate?
        
        init(userSessionDelegate: UserSessionDelegate) {
            self.userSessionDelegate = userSessionDelegate
        }
        
        func signedIn(_ userSession: UserSession) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.userSessionDelegate?.signedIn(userSession)
            }
        }
        
        func signOut() {
            self.userSessionDelegate?.signOut()
        }
        
        func profileEdited(_ editedUserSession: UserSession) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.userSessionDelegate?.profileEdited(editedUserSession)
            }
        }
    }

    var container: RootDIContainer!
    var userSessionResponder: FakeUserSessionResponder!
    var scheduler: TestScheduler!
    var subscription: Disposable!
    let fakeUserSession = UserSession(token: "token", account: Account(
        id: 1,
        email: "email@example.com",
        password: nil,
        nickname: "nickname",
        profilePictureUrl: "https://www.example.com"
    ))
    
    override func setUp() {
        self.container = RootDIContainer()
        self.userSessionResponder = FakeUserSessionResponder(userSessionDelegate: container)
        self.scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDown() {
        scheduler.scheduleAt(1000) {
            self.subscription.dispose()
        }
        scheduler = nil
        super.tearDown()
    }
    
    func test_UserSessionDelegate_signedIn_shouldAcceptUserSessionInRootDIContainer() {
        // Given
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: [fakeUserSession]))
        
        // When
        subscription = observable.bind(onNext: { [weak self] userSession in
            self?.userSessionResponder.signedIn(userSession)
        })
        
        scheduler.start()
        
        // Then
        guard let result = try? container.userSession
            .toBlocking()
            .last() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        XCTAssertEqual(result, fakeUserSession)
    }
    
    func test_UserSessionDelegate_signOut_shouldAcceptUserSessionNilInRootDIContainer() {
        // Given
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: [()]))
        
        // When
        subscription = observable.bind(onNext: { [weak self] in
            self?.userSessionResponder.signOut()
        })
        
        scheduler.start()
        
        // Then
        guard let result = try? container.userSession
            .toBlocking()
            .last() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        XCTAssertNil(result)
    }
    
    func test_UserSessionDelegate_profileEdited_shouldAcceptEditedUserSessionInRootDIContainer() {
        // Given
        container.userSession.accept(fakeUserSession)
        let editedUserSesion = UserSession(token: "token", account: Account(
            email: "new_email@example.com",
            nickname: "newNickname",
            profilePictureUrl: "https://www.newpictureurl.com"
        ))
        let observable = scheduler.createColdObservable(makeRecordedEvents(by: [editedUserSesion]))
        
        // When
        subscription = observable.bind(onNext: { [weak self] editedUserSession in
            self?.userSessionResponder.profileEdited(editedUserSesion)
        })
        
        scheduler.start()
        
        // Then
        guard let result = try? container.userSession
            .toBlocking()
            .last() else {
            XCTFail("failed" + getLocation())
            return
        }
        
        XCTAssertEqual(result, editedUserSesion)
    }
}
