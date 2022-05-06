//
//  NetworkError.swift
//  ReciptopiaKit
//
//  Created by 김세영 on 2022/05/06.
//

import Foundation

internal enum NetworkError: LocalizedError {
    case unknown
    case badURL
    case badResponse(code: Int)
    case encode
    case decode
    case emptyData
}
