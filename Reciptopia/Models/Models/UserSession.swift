//
//  UserSession.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/07.
//

import Foundation

public struct UserSession: Codable {
    public let token: String
    public let account: Account
}

extension UserSession: Equatable {}
