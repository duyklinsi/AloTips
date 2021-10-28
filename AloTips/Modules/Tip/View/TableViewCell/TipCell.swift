//
//  TipCell.swift
//  AloTips
//
//  Created by Duy Nguyen on 5/18/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

class TipCell: UITableViewCell {
    
    @IBOutlet weak var oddsLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var teamsLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipTypeLabel: UILabel!
    @IBOutlet weak var authorButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var didSelectAuthor: ((String?)->())?
    var didSelectFollow: ((Bool)->())?

    var tipModel: TipModel? {
        didSet {
            if let tip = tipModel {
                self.configCell(tip)
            }
        }
    }
    
    func configCell(_ tipModel: TipModel) {
//        self.teamsLabel.text = (tipModel.homeTeam ?? "") + " - " + (tipModel.awayTeam ?? "")
//        self.tipTypeLabel.text = tipModel.tip ?? ""
//        self.timeLabel.text = tipModel.hour
//        self.leagueLabel.text = tipModel.name_league
//        self.oddsLabel.text = tipModel.odds
//        self.authorLabel.text = tipModel.username
//        self.followButton.isSelected = tipModel.isFollow
        
        // setup tip to show UI
//        switch tip.tip {
//        case OddsType.europe.rawValue:
//            if tip.type == "1" {
//                self.tipLabel.text = tip.homeTeam
//            } else if tip.type == "X" {
//                self.tipLabel.text = "Draw"
//            } else {
//                self.tipLabel.text = tip.awayTeam
//            }
//        case OddsType.asianHandicap.rawValue, OddsType.haftHandicap.rawValue:
//            if let array = tip.type?.components(separatedBy: " "), array.count > 0 {
//                let first = array.first
//                if first == "1" {
//                    self.tipLabel.text = (tip.homeTeam ?? "") + " " + (array.last ?? "")
//                } else {
//                    self.tipLabel.text = (tip.awayTeam ?? "") + " " + (array.last ?? "")
//                }
//            }
//        default:
//            self.tipLabel.text = tip.type
//        }
        
//        // setup results
//        switch tip.resultType {
//        case .win:
//            self.resultLabel.backgroundColor = kBlueColor
//            self.resultLabel.text = "W"
//        case .lose:
//            self.resultLabel.backgroundColor = kRedColor
//            self.resultLabel.text = "L"
//        case .draw:
//            self.resultLabel.backgroundColor = kYellowColor
//            self.resultLabel.text = "D"
//        default:
//            self.resultLabel.backgroundColor = kPurpleLightColor
//            self.resultLabel.text = "?"
//        }
        
    }
    
    @IBAction func authorButtonTapped(_ sender: Any) {
    }
    
    @IBAction func followButtonTapped(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected = !button.isSelected
        self.didSelectFollow?(button.isSelected)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.resultLabel.layer.cornerRadius = self.resultLabel.frame.width / 2
        self.resultLabel.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    

}
