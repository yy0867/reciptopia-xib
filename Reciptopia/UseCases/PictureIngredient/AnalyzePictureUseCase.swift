//
//  AnalyzePictureUseCase.swift
//  ReciptopiaKit
//
//  Created by 김세영 on 2022/05/06.
//

import Foundation
import RxSwift

final class AnalyzePictureUseCase: AnalyzePictureUseCaseProtocol {
    
    // MARK: - Properties
    private let repository: PictureIngredientRepositoryProtocol
    
    // MARK: - Methods
    init(repository: PictureIngredientRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(_ pictures: [Data]) -> Observable<[String]> {
        
    }
}
