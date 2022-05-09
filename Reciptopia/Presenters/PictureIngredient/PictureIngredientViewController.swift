//
//  PictureIngredientViewController.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/09.
//

import UIKit
import RxSwift
import RxCocoa

final class PictureIngredientViewController: UIViewController, StoryboardInstantiable {
    
    // MARK: - Outlets
    @IBOutlet weak var searchByNameButton: UIButton!
    
    @IBOutlet weak var managePictureButton: UIButton!
    @IBOutlet weak var analyzePictureButton: UIButton!
    
    @IBOutlet weak var albumButton: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var toggleFlashlightButton: UIButton!
    
    // MARK: - Properties
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewDetail()
    }
    
    private func configureViewDetail() {
        analyzePictureButton.layer.cornerRadius = 10
    }
}
