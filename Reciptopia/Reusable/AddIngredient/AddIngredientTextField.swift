//
//  AddIngredientTextField.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/11.
//

import UIKit

@IBDesignable
open class AddIngredientTextField: UITextField {

    // MARK: - Properties
    @IBInspectable
    public var borderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else { return nil }
            return UIColor(cgColor: borderColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    // MARK: - Methods
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        configureCornerRadius(with: rect)
        textAlignment = .center
    }
    
    private func configureCornerRadius(with rect: CGRect) {
        layer.cornerRadius = rect.height / 2
    }
}
