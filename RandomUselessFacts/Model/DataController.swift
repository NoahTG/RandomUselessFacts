//
//  DataController.swift
//  RandomUselessFacts
//
//  Created by NTG on 12/21/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import Foundation
import CoreData

// the class that manages core data stack
class DataController {
    
        //MARK: Properties
    
    
        // Create persistent container
        let persistentContainer:NSPersistentContainer
        
        // property to access context of main queue
        var viewContext:NSManagedObjectContext{
            return persistentContainer.viewContext
        }
            
        // MARK: Initializers
    
        init(modelName:String) {
            persistentContainer = NSPersistentContainer(name: modelName)
        }
    
         //The completion handler called to load the persistent store via core data
        func load(completion: (() -> Void)? = nil) {
               persistentContainer.loadPersistentStores { storeDescription, error in
                   guard error == nil else {
                       fatalError(error!.localizedDescription)
                   }
                   completion?()
               }
           }
        
        // persists any context changes if true
        func save() throws {
            if viewContext.hasChanges {
                try? viewContext.save()
            }
        
        }
}
    
