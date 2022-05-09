//
//  PhotoViewDelegate.swift
//  PhotoKit
//
//  Created by 김세영 on 2022/05/09.
//

import AVFoundation
import UIKit

public protocol PhotoViewDelegate: AnyObject {
    func photoView(_ photoView: PhotoView, didTakePhoto photo: UIImage?)
}
