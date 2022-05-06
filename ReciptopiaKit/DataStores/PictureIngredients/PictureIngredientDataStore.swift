//
//  PictureIngredientDataStore.swift
//  ReciptopiaKit
//
//  Created by 김세영 on 2022/05/06.
//

import Foundation
import RxSwift

internal final class PictureIngredientDataStore: PictureIngredientRepositoryProtocol {
    
    // MARK: - Properties
    
    // MARK: - Methods
    func analyze(_ pictures: [Data]) -> Observable<[String]> {
        return Observable.create { observer in
            observer.onNext([])
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}
