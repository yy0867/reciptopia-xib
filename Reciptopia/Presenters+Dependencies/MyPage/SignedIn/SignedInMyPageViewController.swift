//
//  SignedInMyPageViewController.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import UIKit

class SignedInMyPageViewController:
    UITableViewController,
    MyPageViewControllerProtocol,
    StoryboardInstantiable
{
    // MARK: - Outlets
    
    
    // MARK: - Properties
    var viewModel: SignedInMyPageViewModel!
    
    // MARK: - Methods
    static func create(with viewModel: SignedInMyPageViewModel) -> Self {
        let vc = self.instantiateViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
