//
//  FactsDetailsViewController.swift
//  RandomUselessFacts
//
//  Created by NTG on 12/22/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import UIKit
import CoreData

class FactDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var savedFactLabel: UILabel!
    
    
    // MARK: - PROPERTIES
    
    var fact: Fact!
    //     var factPersistence: FactPersistence!
    
    var dataController:DataController!
    
    /// A date formatter for the view controller's title text
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }()
    
    //    MARK: - SET UP VIEW
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let creationDate = fact.creationDate {
            navigationItem.title = dateFormatter.string(from: creationDate)
        }
        savedFactLabel.text = fact.data
    }
    
    // MARK: - Actions
    
    @IBAction func deleteFact(sender: Any) {
        showDeleteFactAlert()
    }
    
}

