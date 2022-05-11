//
//  AddIngredientButton.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/10.
//

import UIKit

@IBDesignable
open class AddIngredientButton: UIButton {

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
        addPlusImage()
    }
    
    private func configureCornerRadius(with rect: CGRect) {
        layer.cornerRadius = rect.height / 2
    }
    
    private func addPlusImage() {
        let imageView = UIImageView(image: UIImage(systemName: "plus"))
        imageView.tintColor = UIColor(named: "AccentColor")
        imageView.preferredSymbolConfiguration = .init(pointSize: 20)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
