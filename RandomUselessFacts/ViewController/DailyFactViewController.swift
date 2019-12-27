//
//  DailyFactViewController.swift
//  RandomUselessFacts
//
//  Created by NTG on 12/21/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import UIKit
import CoreData

class DailyFactViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var currentFact:String?
    var newFact: String?
    var dataController: DataController!
    var uselessFactsClient: UselessFactsClient!
    
    // MARK: - View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.isHidden = false
        UselessFactsClient.getFactOfTheDay(completion: handleFactOfTheDayResponse(success:error:))
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let uselessFact = UserDefaults.standard.value(forKey: "HasStoredFact") {
            if uselessFact as! Bool {
                self.factLabel.text = UserDefaults.standard.value(forKey: "StoredFact") as? String
                self.currentFact = UserDefaults.standard.value(forKey: "StoredFact") as? String
            }
        }
    }
    
    @IBAction func newRandomFactTapped(_ sender: Any) {
        loadingIndicator.isHidden = false
        UselessFactsClient.getRandomFact(completion: handleRandomFactResponse(success:error:))
    }
    
    // MARK: - Response Handlers
    func handleFactOfTheDayResponse(success: UselessFactResponse?, error: Error?) {
        DispatchQueue.main.async {
            self.loadingIndicator.isHidden = true
            
            if success != nil {
                self.currentFact = success!.fact
                self.refresh()
            } else {
                self.showAlert(title: "Failed to get useless fact of the day", message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func handleRandomFactResponse(success: UselessFactResponse?, error: Error?) {
        DispatchQueue.main.async {
            if success != nil {
                self.newFact = success!.fact
            } else {
                self.loadingIndicator.isHidden = true
                self.showAlert(title: "Failed to get new random useless fact", message: error?.localizedDescription ?? "")
            }
        }
    }
    
    // MARK: - Helper Functions
      func refresh() {
          UserDefaults.standard.setValue(true, forKey: "HasStoredFact")
          
          self.factLabel.text = self.currentFact
          UserDefaults.standard.setValue(self.currentFact, forKey: "StoredFact")
      }
    
//    MARK: - SEGUE
      

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let vc = segue.destination as! NotebooksListViewController
            vc.dataController = self.dataController
    
               if segue.identifier == "saveToFactsLists" {
                   if (currentFact != nil) {
                    vc.factToSave = currentFact!
                   }
               }
       }
    

}

