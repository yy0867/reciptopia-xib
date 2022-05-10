//
//  ManagePictureViewController.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/10.
//

import UIKit

class ManagePictureViewController: UIViewController, StoryboardInstantiable {
    
    // MARK: - Properties
    private var viewModel: PictureIngredientViewModel!

    // MARK: - Methods
    static func create(with viewModel: PictureIngredientViewModel) -> Self {
        let vc = self.instantiateViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
