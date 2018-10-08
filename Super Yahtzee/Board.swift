//
//  Board.swift
//  Super Yahtzee
//
//  Created by Anders Ravn on 09/09/2018.
//  Copyright © 2018 Anders Ravn. All rights reserved.
//

import Foundation
import UIKit

class Board: NSObject, UITextFieldDelegate {
    var playerNames: [String]!
    var topRow: [String]!
    var maxColumn: [String]!
    var sumPlays: [String]!
    var calcFields: [String]!
    var specialPlays: [String]!
    var total: [String]!
    var playerColumns: [[UITextField]]! = [] // Totals to the number of players.
    let sumCell = 6
    let bonusCell = 7
    let yatzyCell = 19
    let totalCell = 20
    
    init(playerNames: [String]) {
        super.init()
        self.playerNames = playerNames
        self.topRow = ["", "Max"] + self.playerNames.map {$0.substring(to: 2)}
        self.maxColumn = ["6", "12", "18", "24", "30", "36", "126", "50", "12", "22", "30", "18", "24", "33", "15", "20", "30", "28", "36", "136", "706"]
        self.sumPlays = ["Ones", "Twos", "Threes", "Fours", "Fives", "Sixes"]
        self.calcFields = ["Sum", "Bonus(>83)"]
        self.specialPlays = ["1 pair", "2 pairs", "3 pairs", "3 of a kind", "4 of a kind", "2 x 3 equal", "1-2-3-4-5", "2-3-4-5-6", "1-2-3-4-5-6", "Full house", "Chance", "Super Yatzy"]
        self.total = ["Total"]
        for (playerIndex, _) in self.playerNames.enumerated() {
            var playerCells: [UITextField]! = [] // Totals to the number of vertical cells.
            for (playIndex, _) in self.getInfoColumn().enumerated() {
                if playIndex == self.sumCell || playIndex == self.bonusCell || playIndex == self.totalCell {
                    playerCells.append(createTextField(isUserInteractionEnabled: false, tag: playerIndex + playIndex))
                    continue
                }
                playerCells.append(createTextField(isUserInteractionEnabled: true, tag: playIndex))
            }
            playerColumns.append(playerCells)
        }
    }
    
    func getInfoColumn() -> [String] {
        return self.sumPlays + self.calcFields + self.specialPlays + self.total
    }
    
    func createTextField(isUserInteractionEnabled: Bool, tag: Int) -> UITextField {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 40.00, height: 20.00))
        textField.font = UIFont(name: (textField.font?.fontName)!, size: 12.0)
        textField.textAlignment = .center
        textField.keyboardType = UIKeyboardType.numberPad
        textField.isUserInteractionEnabled = isUserInteractionEnabled
        textField.tag = tag
        textField.delegate = self
        return textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        calculateTotal()
    }
    
    func calculateTotal() -> Void {
        for (index, _) in playerColumns.enumerated() {
            calculateSumPlays(playerCells: playerColumns[index])
            calculateBonus(playerCells: playerColumns[index])
            calculatePlayerTotal(playerCells: playerColumns[index])
            calculateYatzy(playerCells: playerColumns[index])
        }
    }
    
    func calculateSumPlays(playerCells: [UITextField]) -> Void {
        var sum = 0
        for (index, _) in sumPlays.enumerated() {
            if let cell = Int(playerCells[index].text!) {
                sum += cell
            }
        }
        playerCells[self.sumCell].text = String(sum)
    }
    
    func calculateBonus(playerCells: [UITextField]) -> Void {
        if let sumCell = Int(playerCells[self.sumCell].text!) {
            if (sumCell > 83) {
                playerCells[self.bonusCell].text = "50"
            } else {
                playerCells[self.bonusCell].text = ""
            }
        }
    }
    
    func calculatePlayerTotal(playerCells: [UITextField]) -> Void {
        var total = 0
        for index in sumPlays.count...playerCells.count - 1 {
            if index == playerCells.count - 1 {
                playerCells[index].text = String(total)
            } else {
                if let cell = Int(playerCells[index].text!) {
                    total += cell
                }
            }
        }
    }
    
    func calculateYatzy(playerCells: [UITextField]) -> Void {
        if let _ = Int(playerCells[self.yatzyCell].text!) {
            let total = Int(playerCells[self.totalCell].text!)!
            let newTotal = total + 100
            playerCells[self.totalCell].text = String(newTotal)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldValue = textField.text! as NSString
        let newValue = oldValue.replacingCharacters(in: range, with: string)
        var newInteger = 0
        if let value = Int(newValue) {
            newInteger = value
        }
        let maxValue = Int(self.maxColumn[textField.tag])!
        
        // Only updates TextField if the user input is not greater than the max value for the play.
        if newInteger > maxValue {
            return false
        } else {
            return true
        }
    }
}
