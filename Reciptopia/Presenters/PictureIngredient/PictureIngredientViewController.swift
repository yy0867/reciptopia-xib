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
    
    // MARK: - Outlets
    @IBOutlet weak var photoView: PhotoView!
    
    @IBOutlet weak var maskingStackView: UIStackView!
    @IBOutlet weak var managePictureButton: UIButton!
    @IBOutlet weak var analyzePictureButton: UIButton!
    
    @IBOutlet weak var albumButton: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var toggleFlashlightButton: UIButton!
    
    // MARK: - Properties
    
    // MARK: - Methods
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
}

// MARK: - PhotoView Delegate
extension PictureIngredientViewController: PhotoViewDelegate {
    func photoView(_ photoView: PhotoView, didTakePhoto photo: UIImage?) {
        print("photo taken.")
    }
}
