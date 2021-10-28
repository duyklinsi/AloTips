//
//  ContainerViewController.swift
//  AloTips
//
//  Created by Admin on 8/25/21.
//

import UIKit

class ContainerViewController: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Properties
    private lazy var tipsViewController: TipsViewController = {
        var viewController = NavigationController.tip.viewController as! TipsViewController
        return viewController
    }()

    private lazy var statisticViewController: StatisticViewController = {
        var viewController = NavigationController.statistic.viewController as! StatisticViewController
        return viewController
    }()
    
    private var isTip: Bool? = nil {
        didSet {
            guard let isTip = isTip else { return }
            
            // change image for switch button
            let image = isTip ? "ic_list_btn" : "ic_stat_btn"
            let switchButton = createBarButtonItem(barButtonType: .image(image), selector: #selector(switchButtonTapped(_:)))
            setupNavigationBar("LIVE", barColor: .black, itemRights: [switchButton])
            
            // change view controller when switching
            if isTip {
                addChildViewController(tipsViewController, toContainerView: containerView)
                statisticViewController.removeViewAndControllerFromParentViewController()
            } else {
                addChildViewController(statisticViewController, toContainerView: containerView)
                tipsViewController.removeViewAndControllerFromParentViewController()
            }
        }
    }
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        isTip = true
    }
    
    // MARK: - IBAction functions
    @objc
    func switchButtonTapped(_ sender: UIButton!) {
        guard let isTip = isTip else { return }
        self.isTip = !isTip
    }
}

// MARK: - Private functions
extension ContainerViewController {
    private func setupUI() {
        // setup navigation bar
        setupNavigationBar("LIVE", barColor: .black)
    }

}

