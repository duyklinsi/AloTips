//
//  UserModel.swift
//  AloTips
//
//  Created by Admin on 8/10/21.
//

struct UserModel: Codable {
    
    let email, name, image, googleID: String?
    let facebookID, userTitle, level: String?
    let points: Int?
    let userID: String?

    enum CodingKeys: String, CodingKey {
        case email, name, image
        case googleID = "google_id"
        case facebookID = "facebook_id"
        case userTitle = "user_title"
        case level, points
        case userID = "userId"
    }
}
