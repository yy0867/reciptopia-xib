//
//  ImageCell.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/10.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift

class ImageCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var removeButton: UIButton!
    
    // MARK: - Properties
    private let removeHandler = BehaviorRelay<(() -> Void)?>(value: nil)
    private let disposeBag = DisposeBag()

    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        bindIsRemovable()
    }
    
    func configureCell(_ image: UIImage?, removeHandler action: (() -> Void)? = nil) {
        self.removeHandler.accept(action)
        
        self.imageView.image = image
    }
    
    // MARK: - Private
    private func bindIsRemovable() {
        removeHandler
            .map { $0 == nil }
            .bind(to: removeButton.rx.isHidden)
            .disposed(by: disposeBag)
    }
}

// MARK: - IBActions
extension ImageCell {
    
    @IBAction func onRemove(_ sender: UIButton) {
        removeHandler.value?()
    }
}
