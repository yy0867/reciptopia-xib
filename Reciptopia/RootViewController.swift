//
//  RootViewController.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/04.
//

import UIKit

class RootViewController: UIViewController {

    // MARK: - Properties
    private let viewController: PictureIngredientViewController
    
    // MARK: - Methods
    init(viewController: PictureIngredientViewController) {
        self.viewController = viewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.present(viewController, animated: true)
    }
}

