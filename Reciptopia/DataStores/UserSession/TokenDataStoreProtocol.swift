//
//  TokenDataStoreProtocol.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/07.
//

import Foundation

protocol TokenDataStoreProtocol {
    func addToken(_ token: String) -> Bool
    func searchToken() -> String?
    func updateToken(_ token: String) -> Bool
    func deleteToken() -> Bool
}
