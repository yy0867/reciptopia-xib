//
//  RootDIContainer.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/10.
//

import Foundation

class RootDIContainer {
    
    // MARK: - Long Lived
    private let pictureIngredientViewModel: PictureIngredientViewModel
    
    init() {
        func makePictureIngredientViewModel() -> PictureIngredientViewModel {
            let useCase = makeAnalyzePictureUseCase()
            return PictureIngredientViewModel(useCase: useCase)
        }
        
        func makeAnalyzePictureUseCase() -> AnalyzePictureUseCaseProtocol {
            let repository = makePictureIngredientRepository()
            return AnalyzePictureUseCase(repository: repository)
        }
        
        func makePictureIngredientRepository() -> PictureIngredientRepositoryProtocol {
            let dataStore = makePictureIngredientDataStore()
            return PictureIngredientRepository(dataStore: dataStore)
        }
        
        func makePictureIngredientDataStore() -> PictureIngredientDataStoreProtocol {
            return PictureIngredientDataStore()
        }
        
        self.pictureIngredientViewModel = makePictureIngredientViewModel()
    }
    
    // MARK: - Factories
    func makeRootViewController() -> RootViewController {
        let vc = makePictureIngredientViewController()
        return RootViewController(viewController: vc)
    }
    
    func makePictureIngredientViewController() -> PictureIngredientViewController {
        let viewModel = pictureIngredientViewModel
        return PictureIngredientViewController.create(with: viewModel)
    }
}
