//
//  UserSessionDelegate.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/11.
//

import Foundation

protocol UserSessionDelegate: AnyObject {
    func signedIn(_ userSession: UserSession)
    func signOut()
    func profileEdited(_ editedUserSession: UserSession)
}
