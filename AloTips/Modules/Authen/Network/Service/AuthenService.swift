//
//  AuthenService.swift
//  AloTips
//
//  Created by Admin on 8/21/21.
//

import Foundation
import CommonFramework

typealias GetUserModelResponseHandler = (Result<UserModel?, BaseAPIError>) -> Void

class AuthenService: BaseService {
    func login(userId: String, completion: @escaping (GetUserModelResponseHandler)) {
        provider.request(MultiTarget(AuthenAPI.login(userId: userId)), type: UserModel.self) { result in
            completion(result)
        }
    }
}
