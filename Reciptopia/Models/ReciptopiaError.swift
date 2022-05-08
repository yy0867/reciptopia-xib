//
//  ReciptopiaError.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/07.
//

import Foundation

enum ReciptopiaError: LocalizedError {
    case unknown
    case notFound
    
    var errorDescription: String? {
        switch self {
            case .unknown:
                return "Unknown error detected."
            case .notFound:
                return "Item not found."
        }
    }
}
