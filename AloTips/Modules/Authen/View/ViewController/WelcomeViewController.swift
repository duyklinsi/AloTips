//
//  WelcomeViewController.swift
//  AloTips
//
//  Created by Admin on 8/20/21.
//

import UIKit

class WelcomeViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var gmailButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var loginEmailButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!

    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    deinit {
        print("▶︎▶︎▶︎▶︎▶︎▶︎▶︎▶︎▶︎▶︎▶︎ deinit \(self)")
    }
    
    // MARK: - IBAction functions
    @IBAction func facebookButtonTapped(_ sender: Any) {
    }
    
    @IBAction func gmailButtonTapped(_ sender: Any) {
    }
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        if let signupVC = UIStoryboard(name: "Authen", bundle: nil).instantiateViewController(withClass: SignupViewController.self) {
            self.navigationController?.pushViewController(signupVC, animated: true)
        }
    }
    
    @IBAction func loginEmailButtonTapped(_ sender: Any) {
        if let loginVC = UIStoryboard(name: "Authen", bundle: nil).instantiateViewController(withClass: LoginViewController.self) {
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }

}

// MARK: - Private functions
extension WelcomeViewController {
    private func setupUI() {
        // hide keyboard
        hideKeyboardWhenTappedAround()
        
        // setup navigation bar
        setupNavigationBar(barColor: .clear)
    }
}
