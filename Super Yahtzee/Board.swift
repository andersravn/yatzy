//
//  Board.swift
//  Super Yahtzee
//
//  Created by Anders Ravn on 09/09/2018.
//  Copyright © 2018 Anders Ravn. All rights reserved.
//

import Foundation
import UIKit

class Board {
    var playerNames: [String]!
    var topRow: [String]!
    var sumPlays: [String]!
    var calcFields: [String]!
    var specialPlays: [String]!
    var total: [String]!
    var playCells: [[UITextField]]! = [] // Totals to the number of players.
    
    init(playerNames: [String]) {
        self.playerNames = playerNames
        self.topRow = ["", "Max"] + self.playerNames.map {$0.substring(to: 2)}
        self.sumPlays = ["Ones", "Twos", "Threes", "Fours", "Fives", "Sixes"]
        self.calcFields = ["Sum", "Bonus(>83)"]
        self.specialPlays = ["1 pair", "2 pairs", "3 pairs", "4 pairs", "2 x 3 equal", "1-2-3-4-5", "2-3-4-5-6", "1-2-3-4-5-6", "Full house", "Chance", "Super Yatzy"]
        self.total = ["Total"]
        for _ in self.playerNames {
            var playerCells: [UITextField]! = [] // Totals to the number of vertical cells.
            for (index, _) in self.getInfoColumn().enumerated() {
                if index == 6 || index == 7 || index == 19 {
                    playerCells.append(createTextField(isUserInteractionEnabled: false))
                    continue
                }
                playerCells.append(createTextField(isUserInteractionEnabled: true))
            }
            playCells.append(playerCells)
        }
    }
    
    func getInfoColumn() -> [String] {
        return [""] + self.sumPlays + self.calcFields + self.specialPlays + self.total
    }
    
    func createTextField(isUserInteractionEnabled: Bool) -> UITextField {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 40.00, height: 20.00))
        // textField.backgroundColor = UIColor(red:0.57, green:0.80, blue:0.64, alpha:1.0)
        // textField.textColor = UIColor.white
        // textField.placeholder = "Player \(playerNumber + 1)"
        // textField.borderStyle = UITextBorderStyle.roundedRect
        textField.font = UIFont(name: (textField.font?.fontName)!, size: 10.0)
        textField.textAlignment = .center
        textField.keyboardType = UIKeyboardType.numberPad
        textField.isUserInteractionEnabled = isUserInteractionEnabled
        return textField
    }
}
