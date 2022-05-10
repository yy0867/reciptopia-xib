//
//  UICollectionViewCell+.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/10.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
