//
//  NotebookCell.swift
//  RandomUselessFacts
//
//  Created by NTG on 12/24/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import UIKit

internal final class NotebookCell: UITableViewCell, Cell {
    // Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var listCountlabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        listCountlabel.text = nil
    }
    
    
}
