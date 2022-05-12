//
//  CheckIngredientViewController.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/10.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class CheckIngredientViewController: UIViewController, StoryboardInstantiable {
    
    enum AddIngredientState {
        case none
        case editing
    }
    
    // MARK: - Outlets
    @IBOutlet weak var addIngredientButton: BorderImageButton!
    @IBOutlet weak var addIngredientTextField: AddIngredientTextField!
    @IBOutlet weak var ingredientCollectionView: UICollectionView!
    @IBOutlet weak var findRecipeButton: UIButton!
    
    // MARK: - Properties
    private var viewModel: CheckIngredientViewModel!
    private let disposeBag = DisposeBag()
    private let addIngredientState = BehaviorRelay<AddIngredientState>(value: .none)

    // MARK: - Methods
    static func create(with viewModel: CheckIngredientViewModel) -> Self {
        let vc = self.instantiateViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        registerCell()
        bindViewModel()
        bindAddIngredientState()
    }
    
    private func configureView() {
        findRecipeButton.setTitle("검색할 재료를 추가해주세요.", for: .disabled)
    }
    
    private func registerCell() {
        ingredientCollectionView.registerNib(IngredientCell.self)
    }
}

// MARK: - Bind ViewModel + State
extension CheckIngredientViewController {
    private func bindViewModel() {
        bindIngredientsEmptyStateToButton()
        bindIngredientsFullStateToButton()
        bindIngredientsToCollectionView()
    }
    
    private func bindIngredientsEmptyStateToButton() {
        viewModel.ingredients
            .map { $0.isEmpty }
            .bind(to: findRecipeButton.rx.isDisabled)
            .disposed(by: disposeBag)
    }
    
    private func bindIngredientsFullStateToButton() {
        viewModel.ingredients
            .map(isIngredientCountFull)
            .bind(to: addIngredientButton.rx.isDisabled)
            .disposed(by: disposeBag)
    }
    
    private func isIngredientCountFull(_ ingredients: [Ingredient]) -> Bool {
        return ingredients.count >= viewModel.maxCount
    }
    
    private func bindIngredientsToCollectionView() {
        viewModel.ingredients
            .bind(to: ingredientCollectionView.rx.items(
                cellIdentifier: IngredientCell.reuseIdentifier,
                cellType: IngredientCell.self
            ))(bindIngredientToCell)
            .disposed(by: disposeBag)
    }
    
    private func bindIngredientToCell(index: Int, item: Ingredient, cell: IngredientCell) {
        cell.configureCell(
            ingredient: item,
            removeHandler: removeIngredient(at: index)
        )
    }
    
    private func removeIngredient(at index: Int) -> (() -> Void) {
        return { [weak self] in
            self?.viewModel.removeIngredient(at: index)
        }
    }
    
    private func bindAddIngredientState() {
        addIngredientState
            .map { $0 == .editing }
            .bind(
                to: addIngredientButton.rx.isHidden,
                addIngredientTextField.rx.isShown
            )
            .disposed(by: disposeBag)
    }
}

// MARK: - IBActions
extension CheckIngredientViewController {
    @IBAction func onDismiss(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func onAddIngredient(_ sender: UIButton) {
        addIngredientState.accept(.editing)
        addIngredientTextField.becomeFirstResponder()
    }
}

// MARK: - UICollectionView Delegate
extension CheckIngredientViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.toggleState(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 100, height: 45)
    }
}

// MARK: - AddIngredientField Delegate
extension CheckIngredientViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        viewModel.addIngredient(text)
        textField.text = ""
        textField.endEditing(true)
        addIngredientState.accept(.none)
        return true
    }
}
