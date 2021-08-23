//
//  BaseAPIRequest.swift
//  CommonFramework
//
//  Created by Admin on 8/11/21.
//

import Foundation
import Moya

public protocol BaseAPIRequest : TargetType {
    var body:[String: Any] {get}
}

extension BaseAPIRequest {
    
    public var baseURL: URL {
        return URL(string: Configs.Network.baseUrl)!
    }
    
    public var method: Moya.Method {
        switch self {
        default: return .get
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var path: String {
        return "/"
    }
    
    public var body: [String : Any] {
        get {
            return [:]
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
    // For json encode. Use in post request
    public var jsonEncoding: JSONEncoding {
        return JSONEncoding.default
    }

    // For param encode. Use in get request
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    
}
