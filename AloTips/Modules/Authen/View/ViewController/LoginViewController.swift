//
//  LoginViewController.swift
//  AloTips
//
//  Created by Admin on 8/20/21.
//

import UIKit
import MaterialComponents
import RxSwift
import CommonFramework
import RxCocoa


class LoginViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var passwordTextfield: MDCFilledTextField!
    @IBOutlet weak var emailTextfield: MDCFilledTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    // MARK: - Properties
    var loginViewModel: LoginViewModel!
    let disposeBag = DisposeBag()
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        bindTextfieldsToViewModel()
        subscribeToLoginButton()
        subscribeToSignupButton()
        subscribeToForgotButton()
        subscribeToLoading()
        subscribeToResponse()
        subcribeToCheckValidate()
        subcribeToTextfields()
    }
    
    deinit {
        print("▶︎▶︎▶︎▶︎▶︎▶︎▶︎▶︎▶︎▶︎▶︎ deinit \(self)")
    }
}

// MARK: - Private functions
extension LoginViewController {
    private func setupUI() {
        //setup navigation bar
        setupNavigationBar("LOGIN", barColor: .clear, itemLefts: [backBarButtonItem])
        
        // hide keyboard
        hideKeyboardWhenTappedAround()
        
        // setup email textfield
        emailTextfield.label.text = "Your Email *"
        emailTextfield.style()
        
        // setup password textfield
        passwordTextfield.label.text = "Your Password *"
        passwordTextfield.style()
    }
    
    private func setupData() {
        // setup login view model
        if loginViewModel == nil {
            loginViewModel = LoginViewModel(authenService: AuthenService())
        }
    }
    
    private func bindTextfieldsToViewModel() {
        emailTextfield.rx.text.orEmpty.bind(to: loginViewModel.emailBehavior).disposed(by: disposeBag)
        passwordTextfield.rx.text.orEmpty.bind(to: loginViewModel.passwordBehavior).disposed(by: disposeBag)
    }
    
    private func subscribeToLoginButton() {
        loginButton.rx.tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                if !self.loginViewModel.validateData() { return }
                self.loginViewModel.requestLogin("jLvz5D3slWP8wNzOZWtDVgGrq6Q2")
            })
            .disposed(by: disposeBag)
    }
    
    private func subscribeToSignupButton() {
        signupButton.rx.tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                if let signupVC = UIStoryboard(name: "Authen", bundle: nil).instantiateViewController(withClass: SignupViewController.self) {
                    self.navigationController?.pushViewController(signupVC, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func subscribeToForgotButton() {
        forgotButton.rx.tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                if let forgotVC = UIStoryboard(name: "Authen", bundle: nil).instantiateViewController(withClass: ForgotPasswordViewController.self) {
                    self.navigationController?.pushViewController(forgotVC, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func subscribeToLoading() {
        loginViewModel.loadingBehavior
            .subscribe (onNext: {isLoading in
                isLoading ? LoadingManager.shared.show() : LoadingManager.shared.hide()
            })
            .disposed(by: disposeBag)
    }
    
    private func subscribeToResponse() {
        loginViewModel.responseObservable
            .subscribe(onNext: {[weak self] (response) in
                guard let self = self else { return }
                switch response {
                case .success(let userModel):
                    guard let userModel = userModel else { return }
                    print("\(userModel)")
                case .failure(let error):
                    print(error)
                    self.showAlert(title: error.title, message: error.description)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func subcribeToCheckValidate() {
        loginViewModel.validateBehavior
            .subscribe(onNext: { [weak self] (validate) in
                guard let self = self, let validate = validate else { return }
                switch validate {
                case .email(let message):
                    self.emailTextfield.showError(message: message)
                case .password(let message):
                    self.passwordTextfield.showError(message: message)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func subcribeToTextfields() {
        emailTextfield.rx.editingDidEnd
            .subscribe(onNext: { [weak self] value in
                guard let self = self else { return }
                self.emailTextfield.showError(message: nil)
            })
            .disposed(by: disposeBag)
        
        passwordTextfield.rx.editingDidEnd
            .subscribe(onNext: { [weak self] value in
                guard let self = self else { return }
                self.passwordTextfield.showError(message: nil)
            })
            .disposed(by: disposeBag)
    }
}



