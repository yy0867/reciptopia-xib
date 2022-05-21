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
    
    deinit {
        removeKeyboardObserver()
        print("deinit")
    }

    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        addKeyboardObserver()
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
    
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(_ sender: NSNotification) {
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                               as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3) {
                self.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height)
            }
        }
    }
    
    @objc func keyboardWillHide(_ sender: NSNotification) {
        self.transform = .identity
    }
    
    private func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
}
