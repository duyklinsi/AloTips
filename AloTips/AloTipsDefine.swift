//
//  AloTipsDefine.swift
//  AloTips
//
//  Created by Admin on 8/20/21.
//

import Foundation
import UIKit

enum AloTipsColor: String {
    case blue_main_color = "blue_main_color"
    case dark_gray_main_color = "dark_gray_main_color"
    
    func value() -> UIColor {
        return UIColor(named: self.rawValue)!
    }
}

struct AloTipsFont {
    static let avenirNextBold = "AvenirNext-Bold"
    static let avenirNextRegular = "AvenirNext-Regular"
    static let avenirNextMedium = "AvenirNext-Medium"
}
