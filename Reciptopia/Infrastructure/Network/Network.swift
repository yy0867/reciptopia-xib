//
//  Network.swift
//  ReciptopiaKit
//
//  Created by 김세영 on 2022/05/06.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire
import Alamofire

class Network {
    
    // MARK: - Properties
    static let shared = Network()
    private init() {}
    
    // MARK: - Methods
    // MARK: INTERNAL
    func get(_ url: URL) -> Observable<Data> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        configureJSONHeader(of: &urlRequest)
        
        return request(urlRequest)
    }
    
    func post(_ url: URL, body: Encodable, token: String? = nil) -> Observable<Data> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = body.toData()
        configureJSONHeader(of: &urlRequest, token: token)
        
        return request(urlRequest)
    }
    
    func patch(_ url: URL, body: Encodable, token: String? = nil) -> Observable<Data> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PATCH"
        urlRequest.httpBody = body.toData()
        configureJSONHeader(of: &urlRequest, token: token)
        
        return request(urlRequest)
    }
    
    func delete(_ url: URL, token: String? = nil) -> Observable<Data> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        configureJSONHeader(of: &urlRequest, token: token)
        
        return request(urlRequest)
    }
    
    func postMultipart(_ url: URL, datas: [Data], parameters: [String: String]) -> Observable<Data> {
        var urlRequest = URLRequest(url: url)
        urlRequest.method = .post
        urlRequest.addValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        
        return RxAlamofire.upload(
            multipartFormData: configureMultipartFormData(with: datas, parameters: parameters),
            urlRequest: urlRequest
        ).flatMap { $0.rx.data() }
    }
    
    // MARK: PRIVATE
    private func request(_ urlRequest: URLRequest) -> Observable<Data> {
        return RxAlamofire.request(urlRequest)
            .validate(statusCode: 200..<300)
            .data()
    }
    
    private func configureJSONHeader(of urlRequest: inout URLRequest, token: String? = nil) {
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = token {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }
    
    private func configureMultipartFormData(
        with datas: [Data],
        parameters: [String: String]
    ) -> ((MultipartFormData) -> Void) {
        return { multipartFormData in
            for (index, data) in datas.enumerated() {
                multipartFormData.append(data, withName: "file\(index).jpeg")
            }
            for (key, value) in parameters {
                multipartFormData.append(
                    "\(value)".data(using: .utf8)!,
                    withName: key,
                    mimeType: "text/plain"
                )
            }
        }
    }
}

fileprivate extension Encodable {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

fileprivate extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
