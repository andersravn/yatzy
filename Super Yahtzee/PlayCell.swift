//
//  PlayCell.swift
//  Super Yahtzee
//
//  Created by Anders Ravn on 08/09/2018.
//  Copyright © 2018 Anders Ravn. All rights reserved.
//

import Foundation
import UIKit
import SpreadsheetView

class PlayCell: Cell {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.frame = bounds
        
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.backgroundColor = UIColor(red: 0.220, green: 0.471, blue: 0.871, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        
        addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
