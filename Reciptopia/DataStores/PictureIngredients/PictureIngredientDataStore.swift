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
    
    // MARK: - Methods
    func analyze(_ pictures: [Data]) -> Observable<[String]> {
        return Observable.create { observer in
            observer.onNext(["다진 마늘", "스팸", "김치"])
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}
