//
//  PictureIngredientInstances.swift
//  ReciptopiaTests
//
//  Created by 김세영 on 2022/05/06.
//

import Foundation
import RxSwift
@testable import Reciptopia

// MARK: - PictureIngredient
extension DevInstances {
    
    /// return ["스팸", "김치", "다진마늘"]
    class FakePictureIngredientDataStore: PictureIngredientDataStoreProtocol {
        func analyze(_ pictures: [Data]) -> Observable<[String]> {
            return Observable.create { observer in
                observer.onNext(["스팸", "김치", "다진마늘"])
                observer.onCompleted()
                
                return Disposables.create()
            }
        }
    }
    
    /// return ["스팸", "김치", "다진마늘"]
    class FakePictureIngredientRepository: PictureIngredientRepositoryProtocol {
        func analyze(_ pictures: [Data]) -> Observable<[String]> {
            return Observable.create { observer in
                observer.onNext(["스팸", "김치", "다진마늘"])
                observer.onCompleted()
                
                return Disposables.create()
            }
        }
    }
}
