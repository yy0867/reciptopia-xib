//
//  RootDIContainer.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/10.
//

import Foundation
import RxRelay

class RootDIContainer {
    
    // MARK: - Long Lived
    private let pictureIngredientViewModel: PictureIngredientViewModel
    let userSession = BehaviorRelay<UserSession?>(value: nil)
    
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
        return PictureIngredientViewController.create(
            with: viewModel,
            managePictureViewControllerFactory: makeManagePictureIngredientViewController,
            checkIngredientViewControllerFactory: makeCheckIngredientViewController
        )
    }
    
    func makeManagePictureIngredientViewController() -> ManagePictureViewController {
        let viewModel = pictureIngredientViewModel
        return ManagePictureViewController.create(with: viewModel)
    }
    
    func makeCheckIngredientViewController(_ analyzeResult: [Ingredient]) -> CheckIngredientViewController {
        let viewModel = CheckIngredientViewModel(ingredients: analyzeResult)
        return CheckIngredientViewController.create(with: viewModel)
    }
}

extension RootDIContainer: UserSessionDelegate {
    func signedIn(_ userSession: UserSession) {
        self.userSession.accept(userSession)
    }
    
    func signOut() {
        self.userSession.accept(nil)
    }
    
    func profileEdited(_ editedUserSession: UserSession) {
        self.userSession.accept(editedUserSession)
    }
}
