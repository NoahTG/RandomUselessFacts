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

    
    /// A closure that is run when the user asks to delete the current fact
    var onDelete: (() -> Void)?
    
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
        presentDeleteFactAlert()
    }
    
    // MARK: - Helper Functions

    func deleteHandler(alertAction: UIAlertAction) {
            onDelete?()
        }
    
    func presentDeleteFactAlert() {
           
           let alertVC = UIAlertController(title: "Delete Fact",
                                           message: "Do you want to delete this fact?",
                                           preferredStyle: .alert)
           
           alertVC.addAction(UIAlertAction(title: "Cancel",
                                           style: .cancel,
                                           handler: nil))
           
           alertVC.addAction(UIAlertAction(title: "Delete",
                                           style: .destructive,
                                           handler: deleteHandler))
           DispatchQueue.main.async {
               self.present(alertVC, animated: true, completion: nil)
           }
       }
       
    
}

