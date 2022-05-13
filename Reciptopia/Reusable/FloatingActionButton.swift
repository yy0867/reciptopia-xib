//
//  FloatingActionButton.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/13.
//

import UIKit

@IBDesignable
open class FloatingActionButton: UIButton {
    
    @IBInspectable
    public var sideLength: CGFloat {
        get { return _sideLength }
        set { _sideLength = newValue }
    }
    
    @IBInspectable
    public var centerImage: UIImage? {
        get { return _centerImage }
        set { _centerImage = newValue }
    }
    
    private var _sideLength: CGFloat = 50
    private var _centerImage: UIImage? = nil

    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        backgroundColor = UIColor(named: "AccentColor")
        configureCornerRadius(with: rect)
        addImage()
    }
    
    private func configureCornerRadius(with rect: CGRect) {
        layer.cornerRadius = rect.height / 2
    }
    
    private func addImage() {
        if let centerImage = centerImage {
            let imageView = UIImageView(image: centerImage)
            
            imageView.tintColor = .white
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
