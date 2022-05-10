//
//  UICollectionView+.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/10.
//

import UIKit

extension UICollectionView {
    func registerNib(_ nibClass: UICollectionViewCell.Type) {
        let nib = UINib(nibName: nibClass.reuseIdentifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: nibClass.reuseIdentifier)
    }
}
