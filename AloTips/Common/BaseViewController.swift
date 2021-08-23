//
//  BaseViewController.swift
//  AloTips
//
//  Created by Admin on 8/13/21.
//

import Foundation
import UIKit

public enum UINavigationBarButtonType {
    case image(String)
    case text(String, UIColor)
}

open class BaseViewController: UIViewController {
    
    // MARK: - Properties
    /**
     The font to be shown while displaying text
     */
    private let textFont = UIFont(name: AloTipsFont.avenirNextBold, size: 18)!
    /**
     This is the back button which will be used as left button.
     */
    lazy var backBarButtonItem: UIBarButtonItem = {
        return createBarButtonItem(barButtonType: .image("ic_back_btn"), selector: #selector(backBarButtonItemTapped(_:)))
    }()
    
    // MARK: - Life cycles
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    //
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Actions
    /**
     This method will be called when user will click on right navigation bar button. The view controller has to implement the delegate.
     - parameter sender: This will be the rightButton.
     
     */
    @objc
    func backBarButtonItemTapped(_ sender: UIButton!) {
        guard (navigationController?.popViewController(animated:true)) != nil
            else {
                dismiss(animated: true, completion: nil)
                return
        }
    }
}

// MARK: - Public methods
extension BaseViewController {
    /**
     This function is used to customize native Navigation Bar
     - parameter title: The title of Navigation Bar
     - parameter textColor : Color of text on navigation bar
     - parameter barColor : Color of navigation bar
     - parameter itemLefts : Array bar button items show on left
     - parameter itemRights : Array bar button items show on right
     */
    public func setupNavigationBar(_ title: String? = nil,
                                   textColor: UIColor = .white,
                                   barColor: UIColor = .black,
                                   itemLefts: [UIBarButtonItem]? = nil,
                                   itemRights: [UIBarButtonItem]? = nil) {
        hideNavigationBar(false)
        navigationController?.navigationBar.setColors(background: barColor, text: textColor)
        
        if let itemRights = itemRights {
            self.navigationItem.rightBarButtonItems = itemRights
        }
        
        if let itemLefts = itemLefts {
            self.navigationItem.leftBarButtonItems = itemLefts
        }
        
        if let title = title, title.count > 0 {
            self.setNavigationBarTitle(title: title)
        }
    }
    
    /**
     This function is used to set only Title in Navigation Bar
     - parameter title: The title of Navigation Bar
     */
    public func setNavigationBarTitle(title: String) {
        self.navigationItem.title = title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: textFont]
    }
    
    /**
     Set Image instead of Text in UINavigationBar
     - parameter imageName: The image to be shown
     */
    public func setupNavigationBarWithTitleImage(_ imageName: String, showBackButtonIfNeeded show: Bool) {
        self.hideNavigationBar(false)
        let barImageView: UIImageView = UIImageView(image: UIImage(named: imageName))
        self.navigationItem.titleView = barImageView
    }
    
    /**
     Hide or Unhide Navigation Bar
     - parameter hide: A bool to set navigation bar
     */
    public func hideNavigationBar(_ hide: Bool) {
        if self.navigationController != nil {
            self.navigationController!.isNavigationBarHidden = hide
        }
    }
    /**
     This method will used to hide/unhide shadow of navigation bar
     - parameter hide: A boolean which will hide/unhide shadow
     
     */
    public func hideNavBarShaddow(hide : Bool) {
        self.navigationController?.navigationBar.setValue(hide, forKey: "hidesShadow")
    }
    /**
     Pop to specific ViewController
     - parameter backIndex: The index of ViewController fron NavigationController Stack
     - parameter animate: A bool to set animation
     */
    
    public func goBackToIndex(_ backIndex: Int, animated animate: Bool) {
        if (self.navigationController!.viewControllers.count - backIndex) > 0 {
            let controller: BaseViewController = (self.navigationController!.viewControllers[(self.navigationController!.viewControllers.count - 1 - backIndex)] as! BaseViewController)
            self.navigationController!.popToViewController(controller, animated: animate)
        }
    }
    
    /**
     This function is used to create bar button items
     - parameter barButtonType: This is enum UINavigationBarButtonType
     - parameter selector : Selector for touch event
     */
    public func createBarButtonItem(barButtonType: UINavigationBarButtonType, selector: Selector) -> UIBarButtonItem {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: selector))

        switch barButtonType {
        case .text(let text, let color):
            button.setTitle(text, for: .normal)
            button.setTitleColor(color, for: .normal)
            button.titleLabel?.font = textFont
        case .image(let image):
            if let image: UIImage = UIImage(named: image) {
                button.setImage(image, for: .normal)
            }
        }
        
        return UIBarButtonItem(customView: button)
    }
}
