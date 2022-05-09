//
//  PictureIngredientViewModel.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/09.
//

import Foundation
import RxSwift
import RxRelay

final class PictureIngredientViewModel {
    
    // MARK: - Properties
    private let useCase: AnalyzePictureUseCaseProtocol
    
    let pictures = BehaviorRelay<[Data]>(value: [])
    let maxPictureCount = 10
    
    // MARK: - Methods
    init(useCase: AnalyzePictureUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func addPicture(_ data: Data) {
        if pictures.value.count >= 10 { return }
        pictures.append(data)
    }
    
    func removePicture(at index: Int) {
        guard 0 <= index && index < pictures.value.count else { return }
        pictures.remove(at: index)
    }
}
