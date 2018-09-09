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

struct Points {
    var ones = 0
    var twos = 0
    var threes = 0
    var fours = 0
    var fives = 0
    var sixes = 0
    var sum = 0
    var bonus = 0
    var pairs1 = 0
    var pairs2 = 0
    var pairs3 = 0
    var pairs4 = 0
    var twoXThreeEqual = 0
    var low = 0
    var high = 0
    var cameron = 0
    var fullHouse = 0
    var chance = 0
    var total = 0
}

class GameViewController: UIViewController, SpreadsheetViewDataSource, SpreadsheetViewDelegate {
    
    @IBOutlet weak var spreadsheetView: SpreadsheetView!
    
    var playerNames = ["Anders", "Natalie", "Sille", "Emil"]
    var board: Board!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spreadsheetView.dataSource = self
        spreadsheetView.delegate = self
        
        spreadsheetView.register(TopCell.self, forCellWithReuseIdentifier: String(describing: TopCell.self))
        spreadsheetView.register(InfoCell.self, forCellWithReuseIdentifier: String(describing: InfoCell.self))
        spreadsheetView.register(PlayCell.self, forCellWithReuseIdentifier: String(describing: PlayCell.self))
        
        self.board = Board(playerNames: ["Anders", "Natalie", "Sille", "Emil"])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        spreadsheetView.flashScrollIndicators()
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return self.board.topRow.count
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return self.board.getInfoColumn().count
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if case 0 = column {
            return 80
        } else {
            return 40
        }
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return 20
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        // First row
        if indexPath.row == 0 {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TopCell.self), for: indexPath) as! TopCell
            cell.label.text = self.board.topRow[indexPath.column]
            if (indexPath.row % 2 != 0) {
                cell.label.backgroundColor = UIColor(red:0.57, green:0.80, blue:0.64, alpha:0.4)
            }
            return cell
        }
        // First column
        if indexPath.column == 0 {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: InfoCell.self), for: indexPath) as! InfoCell
            cell.label.text = self.board.getInfoColumn()[indexPath.row - 1]
            if (indexPath.row % 2 != 0) {
                cell.label.backgroundColor = UIColor(red:0.57, green:0.80, blue:0.64, alpha:0.4)
            }
            return cell
        }
        
        if (indexPath.column > 1 && indexPath.row > 0) {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: PlayCell.self), for: indexPath) as! PlayCell
            cell.label.text = board.playCells[indexPath.column - 2][indexPath.row - 1]
            if (indexPath.row % 2 != 0) {
                cell.label.backgroundColor = UIColor(red:0.57, green:0.80, blue:0.64, alpha:0.4)
            }
            return cell
        } else {
            return nil
        }
    }
}
