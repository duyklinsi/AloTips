//
//  BaseError.swift
//  TableviewSample
//
//  Created by admin on 2021/04/02.
//

import Foundation

public enum BaseAPIError: Error {
    case parseResponseDataFalse(title: String)
    case requestError(title: String, message: String)
    case errorOfResponse(title: String, message: String, code: String)

    public var description: String {
        switch self {
        case .parseResponseDataFalse:
            return "Parse response data false"
        case .requestError(_, let message):
            return message
        case .errorOfResponse(_, let message, _):
            return message
        }
    }

    public var title: String {
        switch self {
        case .parseResponseDataFalse(let title):
            return title
        case .requestError(let title, _):
            return title
        case .errorOfResponse(let title, _, _):
            return title
        }
    }
    
    public var code: String? {
        switch self {
        case .errorOfResponse(_, _, let code):
            return code
        default: return nil
        }
    }
}
