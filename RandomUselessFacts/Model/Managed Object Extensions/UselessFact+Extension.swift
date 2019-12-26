//
//  UselessFact+Extension.swift
//  RandomUselessFacts
//
//  Created by NTG on 12/21/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import Foundation
import CoreData

extension Fact {
        
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.creationDate = Date()
    }
}

struct FactPersistence: FactPersistenceProtocol {
  
   private init(){}

   func createUselessFact(uselessFact: UselessFactResponse, inNotebook notebook: Notebook) -> Fact {
    guard let context = notebook.managedObjectContext else {
        preconditionFailure("Failed to set notebook context.")
    }

    let fact = Fact(context: context)
    fact.data = uselessFact.fact
    return fact
}
    
    func getFetchedResultsController(forNotebook notebook: Notebook, fromContext context: NSManagedObjectContext) -> NSFetchedResultsController<Fact> {
           
        let fetchRequest: NSFetchRequest<Fact> = Fact.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        let predicate = NSPredicate(format: "list == %@", notebook)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sortDescriptor]

        return NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
       }
       
}
      

// Utility for Creating Fact Managed Object
protocol FactPersistenceProtocol {
    /// Creates a new Fact  NSManagedObject
    /// - Parameters:
    ///     - uselessFact: fact to be persisted.
    ///     - notebook: the notebook associted with the fact.
    func createUselessFact(uselessFact: UselessFactResponse, inNotebook notebook: Notebook) -> Fact

    /// Retrieve Fetched results controller for the associated notebook.
    /// - Parameters:
    ///     - notebook: the notebook that the facts will be retrieved from.
    ///        - context: the managed object context to be fetched.
    /// - Returns: the fetched results controller.
    func getFetchedResultsController(forNotebook notebook: Notebook, fromContext context: NSManagedObjectContext) -> NSFetchedResultsController<Fact>
}
