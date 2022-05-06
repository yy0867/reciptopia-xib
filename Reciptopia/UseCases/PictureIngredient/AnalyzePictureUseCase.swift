//
//  AnalyzePictureUseCase.swift
//  ReciptopiaKit
//
//  Created by 김세영 on 2022/05/06.
//

import Foundation
import RxSwift

public final class AnalyzePictureUseCase: AnalyzePictureUseCaseProtocol {
    
    // MARK: - Properties
    private let repository: PictureIngredientRepositoryProtocol
    
    // MARK: - Methods
    public func execute(_ pictures: [Data]) -> Observable<[String]> {
        
    }
}
