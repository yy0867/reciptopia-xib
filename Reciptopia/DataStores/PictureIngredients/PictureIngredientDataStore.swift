//
//  PictureIngredientDataStore.swift
//  ReciptopiaKit
//
//  Created by 김세영 on 2022/05/06.
//

import Foundation
import RxSwift

final class PictureIngredientDataStore: PictureIngredientDataStoreProtocol {
    
    // MARK: - Properties
    let url = "http://ubinetlab.asuscomm.com:50001/multiple_predict"
    
    // MARK: - Methods
    func analyze(_ pictures: [Data]) -> Observable<[String]> {
        guard let url = URL(string: url) else {
            return .error(ReciptopiaError.invalidURL)
        }
        let analyze = Analyze(files: pictures)
        
        return Network.shared.postMultipart(url, datas: pictures, parameters: [
            "appKey": analyze.appKey,
            "version": analyze.version,
        ]).flatMap(handleResponse)
    }
    
    private func handleResponse(_ response: Data) -> Observable<[String]> {
        guard let response = try? JSONDecoder().decode(AnalyzeResult.self, from: response) else {
            return .error(ReciptopiaError.unknown)
        }
        
        switch response.status {
            case .success:
                if let predicts = response.responseData.predicts {
                    return .just(Array(predicts.values))
                }
            case .failure:
                Log.print(response.responseData.message ?? "analyze fail.")
        }
        
        return .error(ReciptopiaError.unknown)
    }
}
