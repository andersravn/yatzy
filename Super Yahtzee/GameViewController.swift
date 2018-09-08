//
//  GameViewController.swift
//  Super Yahtzee
//
//  Created by Anders Ravn on 26/08/2018.
//  Copyright © 2018 Anders Ravn. All rights reserved.
//

import Foundation
import UIKit
import SpreadsheetView

class GameViewController: UIViewController, SpreadsheetViewDataSource, SpreadsheetViewDelegate {
    
    @IBOutlet weak var spreadsheetView: SpreadsheetView!
    
    var playerNames: [String]!
    var topRow: [String]!
    let sumPlays = ["Ones", "Twos", "Threes", "Fours", "Fives", "Sixes"]
    let calcFields = ["Sum", "Bonus(>83)"]
    let specialPlays = ["1 pair", "2 pairs", "3 pairs", "4 pairs", "2 x 3 equal", "1-2-3-4-5", "2-3-4-5-6", "1-2-3-4-5-6", "Full house", "Chance", "Super Yatzy"]
    let total = "Total"
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spreadsheetView.dataSource = self
        spreadsheetView.delegate = self
        
        spreadsheetView.register(PlayCell.self, forCellWithReuseIdentifier: String(describing: PlayCell.self))
        
        print("Game started!")
        for name in playerNames {
            print(name)
        }
        topRow = ["", "Max"] + playerNames.map {$0.substring(to: 2)}
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        spreadsheetView.flashScrollIndicators()
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return playerNames.count + 2
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return sumPlays.count
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return 40
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return 20
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        if indexPath.row == 0 {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: PlayCell.self), for: indexPath) as! PlayCell
            cell.label.text = topRow[indexPath.column]
            return cell
        }
        if indexPath.column == 0 {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: PlayCell.self), for: indexPath) as! PlayCell
            cell.label.text = sumPlays[indexPath.row - 1]
            return cell
        } else {
            return nil
        }
    }
}
