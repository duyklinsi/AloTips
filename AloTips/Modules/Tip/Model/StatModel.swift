//
//  StatModel.swift
//  AloTips
//
//  Created by Admin on 8/25/21.
//

import Foundation

class StatModel: Codable {
    
    // MARK: - Properties
    var total_draw: String?
    var total_lose: String?
    var total_tips: String?
    var total_win: String?
    var reports: Array<ReportModel>?
    
    enum CodingKeys: String, CodingKey {
        case total_draw, total_lose, total_tips, total_win, reports
    }

}
