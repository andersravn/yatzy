//
//  NumberOfPlayersViewController.swift
//  Super Yahtzee
//
//  Created by Anders Ravn on 23/08/2018.
//  Copyright © 2018 Anders Ravn. All rights reserved.
//

import UIKit

class NumberOfPlayersViewController: UIViewController {

    @IBOutlet weak var numberOfPlayers: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectNumberOfPlayers" {
            let controller = segue.destination as! PlayersViewController
            if let numberOfPlayers = Int(self.numberOfPlayers.text!) {
                controller.numberOfPlayers = numberOfPlayers
            } else {
                print("Not a valid Int.")
            }
        }
    }
}

