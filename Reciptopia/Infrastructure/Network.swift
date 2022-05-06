//
//  Network.swift
//  ReciptopiaKit
//
//  Created by 김세영 on 2022/05/06.
//

import Foundation
import RxSwift
import RxCocoa

class Network {
    
    // MARK: - Properties
    let shared = Network()
    private init() {}
    
    // MARK: - Methods
    // MARK: INTERNAL
    func get(_ url: URL) -> Observable<Data> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        configureHeader(of: &urlRequest)
        
        return request(urlRequest)
    }
    
    func post(_ url: URL, body: Encodable, token: String? = nil) -> Observable<Data> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = body.toData()
        configureHeader(of: &urlRequest, token: token)
        
        return request(urlRequest)
    }
    
    func patch(_ url: URL, body: Encodable, token: String? = nil) -> Observable<Data> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PATCH"
        urlRequest.httpBody = body.toData()
        configureHeader(of: &urlRequest, token: token)
        
        return request(urlRequest)
    }
    
    func delete(_ url: URL, token: String? = nil) -> Observable<Data> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        configureHeader(of: &urlRequest, token: token)
        
        return request(urlRequest)
    }
    
    // MARK: PRIVATE
    private func request(_ urlRequest: URLRequest) -> Observable<Data> {
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                guard let data = data else {
                    observer.onError(NetworkError.nilData)
                    return
                }
                if let error = error {
                    observer.onError(error)
                    return
                }
                if let response = response as? HTTPURLResponse,
                   (200..<300).contains(response.statusCode) {
                    observer.onError(NetworkError.badResponse(code: response.statusCode))
                    return
                }
                observer.onNext(data)
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
        .observe(on: MainScheduler.instance)
    }
    
    private func configureHeader(of urlRequest: inout URLRequest, token: String? = nil) {
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = token {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }
}

fileprivate extension Encodable {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
