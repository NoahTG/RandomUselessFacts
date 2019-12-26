//
//  FactCell.swift
//  RandomUselessFacts
//
//  Created by NTG on 12/22/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import UIKit

internal final class FactCell: UITableViewCell, Cell {
    // Outlets

    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        factLabel.text = nil
        dateLabel.text = nil
    }
}
