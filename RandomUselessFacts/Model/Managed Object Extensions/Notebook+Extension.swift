//
//  Notebook+Extension.swift
//  RandomUselessFacts
//
//  Created by NTG on 12/21/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import Foundation
import CoreData

extension Notebook {
    
    // MARK: Life cycle

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.creationDate = Date()
    }
}

struct NotebookPersistence: NotebookPersistenceProtocol {
    
    // create property to hold persisted photo
    let factPersist : FactPersistence
    
    func saveFact(fact: UselessFactResponse, toNotebook notebook: Notebook) throws {
        guard let context = notebook.managedObjectContext else {
            preconditionFailure("Notebook instance has no context.")
        }

//        fact { (uselessFact) in
//            _ = factPersist.createUselessFact(uselessFact: UselessFactResponse, inNotebook: notebook)
//        }
        
        try context.save()
        
    }
    
    
   
}


// Utility for adding photos to Album Managed Object
protocol NotebookPersistenceProtocol {
    
    /// Create and save facts to the photo album.
    /// - Parameters:
    ///        - facts: the facts from the Facts API response
    ///        - notebook: notebook populated with facts
    func saveFact(fact: UselessFactResponse, toNotebook notebook: Notebook) throws
  
}
