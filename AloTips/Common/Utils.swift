//
//  Utils.swift
//  AloTips
//
//  Created by Admin on 8/24/21.
//

import Foundation
import UIKit
import ESTabBarController_swift

class Utils {
    static func createTabbarViewController() {
        guard let window = UIWindow.key else { return }
        
        // create tabbar view controller
        let tabBarController = ESTabBarController()
        tabBarController.tabBar.shadowImage = nil

        // add view controllers to tabBarController
        tabBarController.viewControllers = [NavigationController.container.value, NavigationController.liveScore.value]
        
        // add tabbar as root view controller
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}

