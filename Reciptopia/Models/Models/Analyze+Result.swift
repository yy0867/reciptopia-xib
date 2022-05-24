//
//  Analyze.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/24.
//

import Foundation

struct Analyze: Encodable {
    let version = "1"
    let appKey = "2022y05m22d"
    let files: [Data]
    
    init(files: [Data]) {
        self.files = files
        Log.print(files)
    }
}

struct AnalyzeResult: Decodable {
    
    enum Status: String {
        case success
        case failure
    }
    
    enum CodingKeys: String, CodingKey {
        case responseData = "response_data"
        case status
    }
    
    let responseData: AnalyzeResponseData
    let status: Status
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.responseData = try container.decode(AnalyzeResponseData.self, forKey: .responseData)
        let statusString = try container.decode(String.self, forKey: .status)
        
        self.status = Status(rawValue: statusString) ?? .failure
    }
}

struct AnalyzeResponseData: Decodable {
    let predicts: [String: String]?
    let message: String?
}
