//
//  StoryboardInstantiable.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/09.
//

import UIKit

enum ControllerType: String {
    case viewController = "ViewController"
    case navigationController = "NavigationController"
}

protocol StoryboardInstantiable: UIViewController {
    static func instantiate<T>(type: T.Type, as controllerType: ControllerType) -> T? where T: UIViewController
}

extension StoryboardInstantiable {
    
    static var identifier: String {
        let className = String(describing: Self.self)
        
        if className.hasSuffix("ViewController") {
            return String(className.dropLast("ViewController".count))
        } else if className.hasSuffix("NavigationController") {
            return String(className.dropLast("NavigationController".count))
        } else {
            return className
        }
    }
    
    static func instantiate<T>(
        type: T.Type,
        as controllerType: ControllerType
    ) -> T? where T: UIViewController {
        let storyboard = UIStoryboard(name: identifier + "ViewController", bundle: nil)
        let viewControllerIdentifier = identifier + controllerType.rawValue
        
        return storyboard.instantiateViewController(
            withIdentifier: viewControllerIdentifier
        ) as? T
    }
}
