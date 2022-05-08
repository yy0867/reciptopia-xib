//
//  KeychainTokenDataStore.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/07.
//

import Foundation

final class KeychainTokenDataStore: TokenDataStoreProtocol {
    
    private typealias KeychainQuery = [CFString: Any]
    
    // MARK: - Properties
    private let vSecAttrAccount: String = "reciptopia_keychain_account"
    private let vSecClass: CFString = kSecClassKey
    private let vSecMatchLimit: CFString = kSecMatchLimitOne
    
    // MARK: - Methods
    func addToken(_ token: String) -> Bool {
        guard let vSecValueData = convertTokenToData(token) else { return false }
        let query: KeychainQuery = [
            kSecClass: vSecClass,
            kSecAttrAccount: vSecAttrAccount,
            kSecValueData: vSecValueData
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            return true
        } else if status == errSecDuplicateItem {
            return updateToken(token)
        } else {
            printDescription(of: status)
            return false
        }
    }
    
    func searchToken() -> String? {
        let searchQuery: KeychainQuery = [
            kSecClass: vSecClass,
            kSecAttrAccount: vSecAttrAccount,
            kSecMatchLimit: vSecMatchLimit,
            kSecReturnAttributes: true,
            kSecReturnData: true,
        ]
        
        var itemRef: CFTypeRef?
        let status = SecItemCopyMatching(searchQuery as CFDictionary, &itemRef)
        
        guard status == errSecSuccess else {
            printDescription(of: status)
            return nil
        }
        guard let items = itemRef as? [String: Any],
              let tokenData = items[kSecValueData as String] as? Data,
              let token = String(data: tokenData, encoding: .utf8) else {
            print("\(#function) - fail to extract token from keychain item.")
            return nil
        }
        return token
    }
    
    func updateToken(_ token: String) -> Bool {
        guard let vSecValueData = convertTokenToData(token) else { return false }
        let searchQuery: KeychainQuery = [
            kSecClass: vSecClass,
            kSecAttrAccount: vSecAttrAccount,
        ]
        let updateQuery: KeychainQuery = [kSecValueData: vSecValueData]
        
        let status = SecItemUpdate(searchQuery as CFDictionary, updateQuery as CFDictionary)
        if status == errSecSuccess {
            return true
        } else {
            printDescription(of: status)
            return false
        }
    }
    
    func deleteToken() -> Bool {
        let searchQuery: KeychainQuery = [
            kSecClass: vSecClass,
            kSecAttrAccount: vSecAttrAccount
        ]
        
        let status = SecItemDelete(searchQuery as CFDictionary)
        if status == errSecSuccess {
            return true
        } else {
            printDescription(of: status)
            return false
        }
    }
    
    // MARK: - PRIVATE
    private func convertTokenToData(_ token: String) -> Data? {
        return token.data(using: .utf8)
    }
    
    private func printDescription(of status: OSStatus, _ function: String = #function) {
        if let description = SecCopyErrorMessageString(status, nil) {
            print(description)
        } else {
            print("\(#file) \(function) - Unknown error detected.")
        }
    }
}
