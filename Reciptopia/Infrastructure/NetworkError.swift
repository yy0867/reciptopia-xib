//
//  NetworkError.swift
//  ReciptopiaKit
//
//  Created by 김세영 on 2022/05/06.
//

import Foundation

enum NetworkError: LocalizedError {
    case unknown
    case badURL(url: URL?)
    case badResponse(code: Int)
    case encode
    case decode
    case nilData
    
    var errorDescription: String? {
        switch self {
            case .unknown:
                return "Unknown error."
            case .badURL(let url):
                return "Cannot use this URL: \(url?.absoluteString ?? "URL is empty.")"
            case .badResponse(let code):
                return "Bad Response from Server, code: \(code)"
            case .encode:
                return "Encode failed."
            case .decode:
                return "Decode failed."
            case .nilData:
                return "Data is nil."
        }
    }
}
