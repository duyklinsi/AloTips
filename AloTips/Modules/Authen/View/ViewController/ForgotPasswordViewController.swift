//
//  ForgotPasswordViewController.swift
//  AloTips
//
//  Created by Admin on 8/13/21.
//

import UIKit
import CommonFramework
import MaterialComponents

class ForgotPasswordViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var emailTextfield: MDCFilledTextField!
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()        
    }
    
    deinit {
        print("▶︎▶︎▶︎▶︎▶︎▶︎▶︎▶︎▶︎▶︎▶︎ deinit \(self)")
    }
    
    // MARK: - Actions
    @IBAction func submitButtonTapped(_ sender: Any) {
    }
    
}

// MARK: - Private methods
extension ForgotPasswordViewController {
    
    private func setupUI() {
        // hide keyboard
        hideKeyboardWhenTappedAround()
        
        // setup email textfield
        emailTextfield.label.text = "Your Email *"
        emailTextfield.style()
        
        //setup navigation bar
        setupNavigationBar("FORGOT PASSWORD", barColor: .clear, itemLefts: [backBarButtonItem])
    }

}
