//
//  SignupViewController.swift
//  AloTips
//
//  Created by Admin on 8/20/21.
//

import UIKit
import MaterialComponents

class SignupViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameTextfield: MDCFilledTextField!
    @IBOutlet weak var emailTextfield: MDCFilledTextField!
    @IBOutlet weak var passwordTextfield: MDCFilledTextField!
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    deinit {
        print("▶︎▶︎▶︎▶︎▶︎▶︎▶︎▶︎▶︎▶︎▶︎ deinit \(self)")
    }

    // MARK: - Actions
    @IBAction func signupButtonTapped(_ sender: Any) {
        passwordTextfield.showError(message: "ccccc")
    }
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected = !button.isSelected
    }
}

// MARK: - Private functions
extension SignupViewController {
    private func setupUI() {
        // hide keyboard
        hideKeyboardWhenTappedAround()
        
        // setup name textfield
        nameTextfield.label.text = "Your Name *"
        nameTextfield.style()

        // setup email textfield
        emailTextfield.label.text = "Your Email *"
        emailTextfield.style()
        
        // setup password textfield
        passwordTextfield.label.text = "Your Password *"
        passwordTextfield.style()

        //setup navigation bar
        setupNavigationBar("SIGNUP", barColor: .clear, itemLefts: [backBarButtonItem])
    }
}

