//
//  RootViewController.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/04.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let vc = PictureIngredientViewController.instantiate(
            type: UINavigationController.self,
            as: .navigationController
        ) else { return }
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: false)
    }
}

