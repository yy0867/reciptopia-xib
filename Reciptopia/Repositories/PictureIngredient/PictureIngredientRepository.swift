//
//  PictureIngredientRepository.swift
//  ReciptopiaKit
//
//  Created by 김세영 on 2022/05/06.
//

import Foundation
import RxSwift

final class PictureIngredientRepository: PictureIngredientRepositoryProtocol {
    
    // MARK: - Properties
    private let dataStore: PictureIngredientDataStoreProtocol
    
    // MARK: - Methods
    init(dataStore: PictureIngredientDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func analyze(_ pictures: [Data]) -> Observable<[String]> {
        return dataStore.analyze(pictures)
    }
}
