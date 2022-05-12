//
//  BorderImageButton.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/10.
//

import UIKit

@IBDesignable
open class BorderImageButton: UIButton {

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
    
    @IBInspectable
    public var centerImage: UIImage? {
        get { return _centerImage }
        set { _centerImage = newValue }
    }
    
    private var _centerImage: UIImage? = nil
    
    // MARK: - Methods
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        configureCornerRadius(with: rect)
        addImage()
    }
    
    private func configureCornerRadius(with rect: CGRect) {
        layer.cornerRadius = rect.height / 2
    }
    
    private func addImage() {
        if let image = _centerImage {
            let imageView = UIImageView(image: image)
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
}
