//
//  AuthenAPI.swift
//  AloTips
//
//  Created by Admin on 8/10/21.
//

import Foundation
import Moya
import CommonFramework

enum AuthenAPI {
    case forgotPassword(email: String)
    case login(userId: String)
}

extension AuthenAPI: BaseAPIRequest {
    var path: String {
        switch self {
        case .forgotPassword(_):
            return "forgot_password.php"
        case .login(_):
            return "update_uid.php"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        if let body = body {
            var multipartData = [MultipartFormData]()
            for (key, value) in body {
                if let str = value as? String {
                    let data = Data(str.utf8)
                    let formData = MultipartFormData(provider: .data(data), name: key)
                    multipartData.append(formData)
                }
            }
            return .uploadMultipart(multipartData)
        }
        return .requestPlain
    }
    
    private var body: [String: Any]? {
        switch self {
        case .forgotPassword(let email):
            var params: [String: Any] = [:]
            params["email"] = email
            return params
        case .login(let userId):
            var params: [String: Any] = [:]
            params["user_id"] = userId
            return params
        }
    }
}

