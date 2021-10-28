//
//  Tip.swift
//  AloTips
//
//  Created by Admin on 8/25/21.
//

import Foundation

struct TipModel: Codable {
    
    // MARK: - Properties
    var tipId: String?
    var hour: String?
    var date: String?
//    var isHide: String?
    var homeTeam: String?
    var awayTeam: String?
    var status: String?
    var time: String?
    var tip: String?
    var type: String?
    var name_league: String?
    var odds: String?
    var description: String?
    var reliability: String?
    var channel_id: String?
    var user_id: String?
//    var name: Int?
//    var isFollow: Bool = false
    
//    enum CodingKeys: String, CodingKey {
//        case tipId, hour, date, isHide, homeTeam = "team_a", awayTeam = "team_b", type, status, time, tip, reliability, name_league, odds, description, channel_id, user_id, username = "name", isFollow = "is_follow"
//    }

}
