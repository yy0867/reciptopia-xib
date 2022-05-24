//
//  Analyze.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/24.
//

import Foundation

struct Analyze: Encodable {
    let version = 1
    let appKey = "2022y05m22d"
    let files: [Data]
    
    init(files: [Data]) {
        self.files = files
    }
}
