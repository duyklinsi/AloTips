//
//  BaseNavigationViewController.swift
//  AloTips
//
//  Created by Admin on 8/24/21.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    private var duringPushAnimation = false

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        interactivePopGestureRecognizer?.delegate = self
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        duringPushAnimation = true
        super.pushViewController(viewController, animated: animated)
    }
    
}

// MARK: - UINavigationControllerDelegate
extension BaseNavigationViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController, animated: Bool) {
        guard let swipeNavigationController = navigationController as? BaseNavigationViewController else { return }
        swipeNavigationController.duringPushAnimation = false
    }
}

// MARK: - UIGestureRecognizerDelegate
extension BaseNavigationViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == interactivePopGestureRecognizer else {
            return true // default value
        }

        // Disable pop gesture in two situations:
        // 1) when the pop animation is in progress
        // 2) when user swipes quickly a couple of times and animations don't have time to be performed
        return viewControllers.count > 1 && duringPushAnimation == false
    }

}


