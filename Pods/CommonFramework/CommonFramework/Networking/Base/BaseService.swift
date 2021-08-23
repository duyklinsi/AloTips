//
//  BaseService.swift
//  TableviewSample
//
//  Created by admin on 2021/04/02.
//

import Foundation

open class BaseService {
    public var provider: NetworkProvider!

    public init(isTest: Bool = false) {
        provider = isTest ? NetworkProvider.stubbingNetworking() : NetworkProvider.defaultNetworking()
    }
}
