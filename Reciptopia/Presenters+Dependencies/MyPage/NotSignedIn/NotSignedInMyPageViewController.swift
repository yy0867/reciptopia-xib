//
//  NotSignedInMyPageViewController.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import UIKit

class NotSignedInMyPageViewController:
    UITableViewController,
    MyPageViewControllerProtocol,
    StoryboardInstantiable
{
    
    // MARK: - Properties
    

    // MARK: - Methods
    static func create(with viewModel: NotSignedInMyPageViewModel) -> Self {
        let vc = self.instantiateViewController()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
