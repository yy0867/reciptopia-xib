//
//  UITableView+.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/19.
//

import UIKit

extension UITableView {
    func registerNib(_ nibClass: UITableViewCell.Type) {
        let nib = UINib(nibName: nibClass.reuseIdentifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: nibClass.reuseIdentifier)
    }
}
