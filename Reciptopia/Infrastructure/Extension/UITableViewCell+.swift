//
//  UITableViewCell+.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/19.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
