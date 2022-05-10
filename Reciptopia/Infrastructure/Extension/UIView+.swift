//
//  UIView+.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/10.
//

import UIKit

extension UIView {
    
    var isShown: Bool {
        get { return !self.isHidden }
        set { self.isHidden = !newValue }
    }
}
