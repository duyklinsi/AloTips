//
//  AuthenService.swift
//  AloTips
//
//  Created by Admin on 8/21/21.
//

import Foundation
import CommonFramework

typealias GetTipsResponseHandler = (Result<TipResponseModel?, BaseAPIError>) -> Void

class TipService: BaseService {
    func getTips(paramater: Dictionary<String, Any>, completion: @escaping (GetTipsResponseHandler)) {
        provider.request(MultiTarget(TipsAPI.getTips(paramater: paramater)), type: TipResponseModel.self) { result in
            completion(result)
        }
    }
}
