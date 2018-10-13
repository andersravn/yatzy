//
//  PlayersViewController.swift
//  Super Yahtzee
//
//  Created by Anders Ravn on 23/08/2018.
//  Copyright © 2018 Anders Ravn. All rights reserved.
//

import Foundation
import UIKit

class PlayersViewController: UIViewController {
    @IBOutlet weak var playersInputContainer: UIStackView!
    
    var numberOfPlayers: Int!
    var playerNameTextFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.hideKeyboardWhenTappedAround()
        
        print("Players: \(self.numberOfPlayers!)")
        var i = 0
        while i < self.numberOfPlayers {
            let textField = createTextField(playerNumber: i)
            playersInputContainer.addArrangedSubview(textField)
            playerNameTextFields.append(textField)
            i += 1
        }
    }
    
    func createTextField(playerNumber: Int) -> UITextField {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200.00, height: 30.00))
        textField.backgroundColor = UIColor(red:0.57, green:0.80, blue:0.64, alpha:1.0)
        textField.textColor = UIColor.white
        textField.placeholder = "Player \(playerNumber + 1)"
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.keyboardType = UIKeyboardType.default
        return textField
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createGame" {
            let controller = segue.destination as! GameViewController
            controller.playerNames = self.getContentFromTextFields(textFields: playerNameTextFields)
        }
    }
    
    func getContentFromTextFields(textFields: [UITextField]) -> [String] {
        var result: [String] = []
        for field in textFields {
            if let text = field.text {
                result.append(text)
            }
        }
        return result
    }
}
