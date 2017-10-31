//
//  TestTableViewCell.swift
//  Example
//
//  Created by Ilya Kulebyakin on 10/20/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import UIKit
import TableViewDataProvider

class TestTableViewCell: TableViewCell {
    
    override class var estimatedHeight: CGFloat {
        return 100.0
    }

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    
}
