//
//  IngredientCell.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/10.
//

import UIKit
import RxCocoa
import RxSwift

open class IngredientCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Properties
    private let isMainIngredient = BehaviorRelay<Bool>(value: false)
    private var removeHandler: () -> Void = {}
    private let disposeBag = DisposeBag()

    // MARK: - Methods
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        bindIsMainIngredientToBackground()
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = rect.height / 2
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        layer.cornerRadius = frame.height / 2
    }
    
    public func configureCell(
        ingredient: Ingredient,
        removeHandler removeAction: @escaping () -> Void
    ) {
        isMainIngredient.accept(ingredient.isMainIngredient)
        nameLabel.text = ingredient.name
        removeHandler = removeAction
    }
    
    // MARK: - Privates
    private func bindIsMainIngredientToBackground() {
        isMainIngredient
            .map(mapIsMainIngredientToColor)
            .bind(to: contentView.rx.backgroundColor)
            .disposed(by: disposeBag)
    }
    
    private func mapIsMainIngredientToColor(_ isMainIngredient: Bool) -> UIColor? {
        return isMainIngredient ? UIColor(named: "MainIngredientColor") : UIColor(named: "AccentColor")
    }
}

// MARK: - IBActions
extension IngredientCell {
    
    @IBAction func onRemove(_ sender: UIButton) {
        removeHandler()
    }
}
