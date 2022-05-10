//
//  StoryboardInstantiable.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/09.
//

import UIKit

protocol StoryboardInstantiable: UIViewController {
    static func instantiateViewController() -> Self
}

extension StoryboardInstantiable {
    
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    static func instantiateViewController() -> Self {
        let storyboard = UIStoryboard(name: identifier, bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(identifier: identifier) as? Self else {
            fatalError(
                "Cannot instantiate view controller: \(identifier)\n" +
                Log.getLocation()
            )
        }
        
        return vc
    }
}
