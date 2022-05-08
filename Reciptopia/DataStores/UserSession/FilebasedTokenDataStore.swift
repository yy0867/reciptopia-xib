//
//  FilebasedTokenDataStore.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/07.
//

import Foundation

final class FilebasedTokenDataStore: TokenDataStoreProtocol {
    
    // MARK: - Properties
    private var documentURL: URL {
        return FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("reciptopia_token.token")
    }
    
    // MARK: - Methods
    func addToken(_ token: String) -> Bool {
        guard let tokenData = convertTokenToData(token) else { return false }
        
        return FileManager.default.createFile(atPath: documentURL.path, contents: tokenData)
    }
    
    func searchToken() -> String? {
        do {
            return try String(contentsOfFile: documentURL.path, encoding: .utf8)
        } catch {
            print("\(#function) - \(error.localizedDescription)")
            return nil
        }
    }
    
    func updateToken(_ token: String) -> Bool {
        guard let tokenData = convertTokenToData(token) else { return false }
        
        return FileManager.default.createFile(atPath: documentURL.path, contents: tokenData)
    }
    
    func deleteToken() -> Bool {
        do {
            try FileManager.default.removeItem(atPath: documentURL.path)
            return true
        } catch {
            print("\(#function) - \(error.localizedDescription)")
            return false
        }
    }
    
    // MARK: - PRIVATE
    private func convertTokenToData(_ token: String) -> Data? {
        return token.data(using: .utf8)
    }
}
