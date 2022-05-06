//
//  Network.swift
//  ReciptopiaKit
//
//  Created by 김세영 on 2022/05/06.
//

import Foundation
import RxSwift
import RxCocoa

internal class Network {
    
    // MARK: - Properties
    let shared = Network()
    private init() {}
    
    // MARK: - Methods
    // MARK: INTERNAL
    func get(_ url: URL) -> Observable<Data> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
}
