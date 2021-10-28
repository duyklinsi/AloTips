//
//  ReportModel.swift
//  AloTips
//
//  Created by Admin on 8/25/21.
//

import Foundation

class ReportModel: Codable {
    
    // MARK: - Properties
    var name: String?
    var value: String?

    enum CodingKeys: String, CodingKey {
        case name, value
    }

}
