//
//  LoadingManager.swift
//  CommonFramework
//
//  Created by Admin on 8/10/21.
//

import UIKit
import NVActivityIndicatorView

public class LoadingManager {
    public static let shared = LoadingManager()
    
    var indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    var containerView = UIView()
    
    public func show(_ type: NVActivityIndicatorType = .ballScaleMultiple, backgroundColor: UIColor = UIColor(white: 0x000000, alpha: 0.4)) {
        guard let window = UIWindow.key else { return }
        containerView.frame = window.frame
        containerView.center = window.center
        containerView.backgroundColor = backgroundColor
        
        indicator.type = type
        indicator.center = CGPoint(x: window.bounds.width / 2, y: window.bounds.height / 2)
        indicator.startAnimating()
        containerView.addSubview(indicator)
        
        window.addSubview(containerView)
    }
    
    public func hide() {
        indicator.stopAnimating()
        containerView.removeFromSuperview()
    }
    
}
