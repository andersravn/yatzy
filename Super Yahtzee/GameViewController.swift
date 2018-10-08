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
    var board: Board!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spreadsheetView.dataSource = self
        spreadsheetView.delegate = self
        
        spreadsheetView.register(TopCell.self, forCellWithReuseIdentifier: String(describing: TopCell.self))
        spreadsheetView.register(InfoCell.self, forCellWithReuseIdentifier: String(describing: InfoCell.self))
        spreadsheetView.register(PlayCell.self, forCellWithReuseIdentifier: String(describing: PlayCell.self))
        
        self.board = Board(playerNames: playerNames)
        
        // Code to hide keyboard on tap.
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(GameViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        spreadsheetView.flashScrollIndicators()
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return self.board.topRow.count
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return self.board.getInfoColumn().count + 1
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if case 0 = column { // The first column should be wider to fit play names.
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
        
        // First column - skips the empty cell in the first row.
        if indexPath.column == 0 && indexPath.row > 0 {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: InfoCell.self), for: indexPath) as! InfoCell
            cell.label.text = self.board.getInfoColumn()[indexPath.row - 1] // -1 to compensate for the empty cell in the first row.
            if (indexPath.row % 2 != 0) {
                cell.label.backgroundColor = UIColor(red:0.57, green:0.80, blue:0.64, alpha:0.4)
            }
            return cell
        }
        
        // Add values to max column.
        if (indexPath.column == 1 && indexPath.row > 0) {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: PlayCell.self), for: indexPath) as! PlayCell
            cell.label.text = self.board.maxColumn[indexPath.row - 1]
            cell.label.font = cell.label.font.withSize(10.0)
            if (indexPath.row % 2 != 0) {
                cell.label.backgroundColor = UIColor(red:0.57, green:0.80, blue:0.64, alpha:0.4)
            }
            return cell
        }
        
        // Adds TextFields to player columns.
        if (indexPath.column > 1 && indexPath.row > 0) {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: PlayCell.self), for: indexPath) as! PlayCell
            cell.addSubview(board.playerColumns[indexPath.column - 2][indexPath.row - 1])
            if (indexPath.row % 2 != 0) {
                cell.label.backgroundColor = UIColor(red:0.57, green:0.80, blue:0.64, alpha:0.4)
            }
            return cell
        } else {
            return nil
        }
    }
    
    // Code to hide keyboard on tap.
    @objc func didTapView(){
        self.view.endEditing(true)
    }
}
