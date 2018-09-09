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
    var playCells: [[String]]! = []
    
    init(playerNames: [String]) {
        self.playerNames = playerNames
        self.topRow = ["", "Max"] + self.playerNames.map {$0.substring(to: 2)}
        self.sumPlays = ["Ones", "Twos", "Threes", "Fours", "Fives", "Sixes"]
        self.calcFields = ["Sum", "Bonus(>83)"]
        self.specialPlays = ["1 pair", "2 pairs", "3 pairs", "4 pairs", "2 x 3 equal", "1-2-3-4-5", "2-3-4-5-6", "1-2-3-4-5-6", "Full house", "Chance", "Super Yatzy"]
        self.total = ["Total"]
        for _ in self.playerNames {
            var playerCells: [String]! = []
            for _ in 0...self.getInfoColumn().count {
                playerCells.append("4")
            }
            playCells.append(playerCells)
        }
    }
    
    func getInfoColumn() -> [String] {
        return self.sumPlays + self.calcFields + self.specialPlays + self.total
    }
}
