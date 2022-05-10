//
//  AppDelegate.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/04.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let rootDIContainer = RootDIContainer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let pictureIngredientViewController = rootDIContainer.makePictureIngredientViewController()
        let navigationController = UINavigationController(rootViewController: pictureIngredientViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

