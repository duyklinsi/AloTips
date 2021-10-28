//
//  AuthenAPI.swift
//  AloTips
//
//  Created by Admin on 8/10/21.
//

import Foundation
import Moya
import CommonFramework

enum TipsAPI {
    case getTips(paramater: Dictionary<String, Any>)
}

extension TipsAPI: BaseAPIRequest {
    var path: String {
        switch self {
        case .getTips(_):
            return "get_tips.php"
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
        case .getTips(let paramater):
            return paramater
        }
    }    
}

