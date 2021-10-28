//
//  TipResponseModel.swift
//  AloTips
//
//  Created by Admin on 8/25/21.
//

import Foundation

class TipResponseModel: Codable {
    
    // MARK: - Properties
    var tips: Array<TipModel>?
    var stat: StatModel?
//    var top_tipsters: Array<UserModel>?

    enum CodingKeys: String, CodingKey {
        case tips, stat = "stats"
    }

}
