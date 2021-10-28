//
//  Enum.swift
//  AloTips
//
//  Created by Admin on 8/25/21.
//

import Foundation
import UIKit

enum TabbarItem {
    case tip
    case liveScore
    
    var title: String {
        switch self {
        case .tip:
            return "Tip"
        case .liveScore:
            return "Live Score"
        }
    }
    
    var image: UIImage {
        switch self {
        case .tip:
            return UIImage(named: "ic_back_btn")!
        case .liveScore:
            return UIImage(named: "ic_back_btn")!
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .tip:
            return UIImage(named: "ic_back_btn")!
        case .liveScore:
            return UIImage(named: "ic_back_btn")!
        }
    }
}

enum NavigationController {
    case container
    case tip
    case liveScore
    case statistic
    
    var tabbarItem: TabbarItem? {
        switch self {
        case .container:
            return .tip
        case .liveScore:
            return .liveScore
        default:
            return nil
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .container:
            return UIStoryboard(name: "Tip", bundle: nil).instantiateViewController(withClass: ContainerViewController.self)!
        case .tip:
            return UIStoryboard(name: "Tip", bundle: nil).instantiateViewController(withClass: TipsViewController.self)!
        case .statistic:
            return UIStoryboard(name: "Tip", bundle: nil).instantiateViewController(withClass: StatisticViewController.self)!
        case .liveScore:
            return UIStoryboard(name: "LiveScore", bundle: nil).instantiateViewController(withClass: LiveScoreViewController.self)!
        }
    }
    
    var value: UINavigationController {
        let vc = viewController
        vc.tabBarItem = UITabBarItem.init(title: tabbarItem?.title, image: tabbarItem?.image, selectedImage: tabbarItem?.selectedImage)
        let navController = BaseNavigationViewController(rootViewController: vc)
        navController.navigationBar.isTranslucent = false
        return navController
    }
}
