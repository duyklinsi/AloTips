//
//  LoginViewModel.swift
//  AloTips
//
//  Created by Admin on 8/20/21.
//

import Foundation
import RxSwift
import RxCocoa
import CommonFramework

enum ValidateField {
    case email(message: String)
    case password(message: String)
}

class LoginViewModel {
    
    // MARK: - Properties
    typealias Response = Result<UserModel?, BaseAPIError>
    
    var emailBehavior = BehaviorRelay<String>(value: "")
    var passwordBehavior = BehaviorRelay<String>(value: "")
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    var validateBehavior = BehaviorRelay<ValidateField?>(value: nil)
    
    private var responseSubject = PublishSubject<Response>()
    var responseObservable: Observable<Response> {
        return responseSubject
    }
    
    var authenService: AuthenService!
    
    // MARK: - Init functions
    init(authenService: AuthenService) {
        self.authenService = authenService
    }
}

// MARK: - Public functions
extension LoginViewModel {
    /**
     This function is used to call Login API
     - parameter userId: userId was retrieved from Firebase
     */
    func requestLogin(_ userId: String) {
        loadingBehavior.accept(true)
        authenService.login(userId: userId) { [weak self] result in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            self.responseSubject.onNext(result)
        }
    }
    
    /// Check validate email and password fields.
    ///
    ///        "email and password".hasValid -> true
    ///        "email and password".notValid -> false
    ///
    func validateData() -> Bool {
        if emailBehavior.value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            validateBehavior.accept(.email(message: "Please input your email."))
            return false
        }
        if !emailBehavior.value.isValidEmail {
            validateBehavior.accept(.email(message: "Email is invalid. Please input another email."))
            return false
        }
        if passwordBehavior.value.isEmpty {
            validateBehavior.accept(.password(message: "Please input your password."))
            return false
        }
        if passwordBehavior.value.count < 6 {
            validateBehavior.accept(.password(message: "Password must be at least 6 characters!"))
            return false
        }
        return true
    }
}
