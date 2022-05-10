//
//  ManagePictureViewController.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/10.
//

import UIKit
import RxSwift
import RxCocoa

class ManagePictureViewController: UIViewController, StoryboardInstantiable {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyPictureLabel: UILabel!
    
    // MARK: - Properties
    private var viewModel: PictureIngredientViewModel!
    private let disposeBag = DisposeBag()

    // MARK: - Methods
    static func create(with viewModel: PictureIngredientViewModel) -> Self {
        let vc = self.instantiateViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        bindPictureEmptyState()
        bindPicturesToCollectionView()
    }
    
    private func registerCell() {
        collectionView.registerNib(ImageCell.self)
    }
}

// MARK: - Bind ViewModel
extension ManagePictureViewController {
    private func bindPictureEmptyState() {
        viewModel.pictures
            .map { $0.isEmpty }
            .bind(to: collectionView.rx.isHidden, emptyPictureLabel.rx.isShown)
            .disposed(by: disposeBag)
    }
    
    private func bindPicturesToCollectionView() {
        viewModel.pictures
            .map(mapDatasToUIImages)
            .bind(to: collectionView.rx.items(
                cellIdentifier: ImageCell.reuseIdentifier,
                cellType: ImageCell.self
            ))(bindImageToCell)
            .disposed(by: disposeBag)
    }
    
    private func mapDatasToUIImages(_ datas: [Data]) -> [UIImage?] {
        return datas.map { UIImage(data: $0) }
    }
    
    private func bindImageToCell(_ index: Int, _ item: UIImage?, _ cell: ImageCell) {
        cell.configureCell(item) { [weak self] in
            self?.viewModel.removePicture(at: index)
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionView Delegate
extension ManagePictureViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideLength = (UIScreen.main.bounds.width / 2) - 15
        return CGSize(width: sideLength, height: sideLength)
    }
}
