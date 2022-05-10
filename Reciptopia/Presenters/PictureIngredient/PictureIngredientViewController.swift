//
//  PictureIngredientViewController.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/09.
//

import UIKit
import RxSwift
import RxCocoa
import PhotoKit

final class PictureIngredientViewController: UIViewController, StoryboardInstantiable {
    
    typealias ManagePictureViewControllerFactory = () -> ManagePictureViewController
    
    // MARK: - Outlets
    @IBOutlet weak var photoView: PhotoView!
    
    @IBOutlet weak var maskingStackView: UIStackView!
    @IBOutlet weak var managePictureButton: UIButton!
    @IBOutlet weak var analyzePictureButton: UIButton!
    
    @IBOutlet weak var albumButton: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    
    // MARK: - Properties
    private var viewModel: PictureIngredientViewModel!
    private var makeManagePictureViewController: ManagePictureViewControllerFactory!
    private let disposeBag = DisposeBag()
    
    // MARK: - Methods
    static func create(
        with viewModel: PictureIngredientViewModel,
        managePictureViewControllerFactory: @escaping ManagePictureViewControllerFactory
    ) -> Self {
        let vc = self.instantiateViewController()
        vc.viewModel = viewModel
        vc.makeManagePictureViewController = managePictureViewControllerFactory
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoView.delegate = self
        configureViewDetail()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        photoView.startPreview()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        photoView.stopPreview()
    }
    
    private func configureViewDetail() {
        analyzePictureButton.layer.cornerRadius = 10
        view.bringSubviewToFront(maskingStackView)
    }
}

// MARK: - Bind ViewModel
extension PictureIngredientViewController {
    private func bindViewModel() {
        bindPictureCountToView()
        bindPictureEmptyStateToView()
        bindPictureFullStateToView()
    }
    
    private func bindPictureCountToView() {
        viewModel.pictures
            .map { $0.count }
            .map(mapPictureCountToAnalyzeButtonLabel)
            .bind(to: analyzePictureButton.rx.title())
            .disposed(by: disposeBag)
        
        viewModel.pictures
            .map { $0.count }
            .map(mapPictureCountToManagePictureButtonLabel)
            .bind(to: managePictureButton.rx.title())
            .disposed(by: disposeBag)
    }
    
    private func mapPictureCountToAnalyzeButtonLabel(_ count: Int) -> String {
        return "\(count)개의 재료 분석하기"
    }
    
    private func mapPictureCountToManagePictureButtonLabel(_ count: Int) -> String {
        return "\(count) / \(viewModel.maxPictureCount)"
    }
    
    private func bindPictureEmptyStateToView() {
        viewModel.pictures
            .map { $0.isEmpty }
            .bind(to: analyzePictureButton.rx.isDisabled, managePictureButton.rx.isDisabled)
            .disposed(by: disposeBag)
    }
    
    private func bindPictureFullStateToView() {
        viewModel.pictures
            .map(isPictureCountFull)
            .bind(to: albumButton.rx.isDisabled, takePhotoButton.rx.isDisabled)
            .disposed(by: disposeBag)
    }
    
    private func isPictureCountFull(_ datas: [Data]) -> Bool {
        return datas.count >= viewModel.maxPictureCount
    }
}

// MARK: - IBActions
extension PictureIngredientViewController {
    
    @IBAction func takePhoto(_ sender: UIButton!) {
        #if targetEnvironment(simulator)
        let image = UIImage(systemName: "photo")
        self.photoView(self.photoView, didTakePhoto: image)
        #else
        photoView.takePhoto()
        #endif
    }
    
    @IBAction func presentManagePicture(_ sender: UIButton!) {
        let vc = makeManagePictureViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - PhotoView Delegate
extension PictureIngredientViewController: PhotoViewDelegate {
    func photoView(_ photoView: PhotoView, didTakePhoto photo: UIImage?) {
        guard let data = photo?.jpegData(compressionQuality: 1) else {
            Log.print("Taken Photo is nil.")
            return
        }
        viewModel.addPicture(data)
    }
}
