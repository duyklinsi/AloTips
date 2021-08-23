//
//  APIResponse.swift
//  TableviewSample
//
//  Created by Admin on 8/10/21.
//

import Foundation

public struct BaseAPIResponse<T: Codable>: Codable {
    var status: Bool?
    var message: String?
    var code: String?
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case status, message, code, data
    }
}
