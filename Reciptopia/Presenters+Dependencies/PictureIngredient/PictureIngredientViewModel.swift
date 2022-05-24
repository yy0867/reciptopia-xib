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
    
    enum AnalyzeState {
        case analyzing
        case errorDetected
        case analyzed(analyzedResult: [Ingredient])
    }
    
    // MARK: - Properties
    private let useCase: AnalyzePictureUseCaseProtocol
    private var subscription: Disposable?
    
    let pictures = BehaviorRelay<[Data]>(value: [])
    let analyzeState = PublishRelay<AnalyzeState>()
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
    
    func analyze() {
        self.analyzeState.accept(.analyzing)
        
        subscription = useCase.execute(pictures.value)
            .subscribe(
                onNext: analyzed,
                onError: errorDetected,
                onDisposed: disposeSubscription
            )
    }
    
    // MARK: - Private
    private func analyzed(with ingredients: [Ingredient]) {
        analyzeState.accept(.analyzed(analyzedResult: ingredients))
    }
    
    private func errorDetected(_ error: Error) {
        analyzeState.accept(.errorDetected)
    }
    
    private func disposeSubscription() {
        self.subscription?.dispose()
    }
}
