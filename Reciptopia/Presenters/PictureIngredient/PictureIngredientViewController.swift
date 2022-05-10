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

// MARK: - IBActions
extension PictureIngredientViewController {
    
    @IBAction func takePhoto(_ sender: UIButton!) {
        photoView.takePhoto()
    }
    
    @IBAction func presentManagePicture(_ sender: UIButton!) {
        let vc = makeManagePictureViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - PhotoView Delegate
extension PictureIngredientViewController: PhotoViewDelegate {
    func photoView(_ photoView: PhotoView, didTakePhoto photo: UIImage?) {
        print("photo taken.")
    }
}
