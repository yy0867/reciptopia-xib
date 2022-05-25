//
//  LoadableImageCell.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/24.
//

import UIKit

open class LoadableImageCell: UICollectionViewCell {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!

    open override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    public func loadImage(at url: URL) {
        defer { indicator.stopAnimating() }
        
        indicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.imageView.image = UIImage(systemName: "photo")
        }
//        guard let imageData = try? Data(contentsOf: url),
//              let image = UIImage(data: imageData) else { return }
//
//        imageView.image = image
    }
}
