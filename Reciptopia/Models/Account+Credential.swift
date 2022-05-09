//
//  Account.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/07.
//

import Foundation

public struct Account: Codable {
    public let id: Int?
    public let email: String
    public let password: String?
    public let nickname: String
    public let profilePictureUrl: String?
    
    init(
        id: Int? = nil,
        email: String,
        password: String? = nil,
        nickname: String,
        profilePictureUrl: String? = nil
    ) {
        self.id = id
        self.email = email
        self.password = password
        self.nickname = nickname
        self.profilePictureUrl = profilePictureUrl
    }
}

struct Credential {
    let email: String
    let password: String
}
