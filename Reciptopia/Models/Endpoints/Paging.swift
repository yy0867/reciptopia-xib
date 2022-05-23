//
//  Paging.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/23.
//

import Foundation

struct Paging {
    
    // MARK: - Properties
    var page: Int
    let size: Int
    
    // MARK: - Methods
    init(page: Int, size: Int = 20) {
        self.page = page
        self.size = size
    }
    
    func asQuery() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "size", value: String(size)),
        ]
    }
    
    mutating func nextPage() {
        self.page += 1
    }
}
