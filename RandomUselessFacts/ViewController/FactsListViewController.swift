//
//  FactsListViewController.swift
//  RandomUselessFacts
//
//  Created by NTG on 12/22/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import UIKit
import CoreData

class FactsListViewController: UIViewController, UITableViewDataSource {
    
    
// MARK: - OUTLETS

    /// A table view that displays a list of notes for a notebook
      @IBOutlet weak var tableView: UITableView!
    
// MARK: - PROPERTIES
    
    /// The notebook whose notes are being displayed
    var notebook: Notebook!

    var dataController:DataController!
    
    var fetchedResultsController:NSFetchedResultsController<Fact>!
   
    /// A date formatter for date text in note cells
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }()
    
//    MARK: - Core Data Fetch Request

    fileprivate func setupFetchedResultsController() {
         let fetchRequest:NSFetchRequest<Fact> = Fact.fetchRequest()
         let predicate = NSPredicate(format: "list == %@", notebook)
         fetchRequest.predicate = predicate
         let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
         fetchRequest.sortDescriptors = [sortDescriptor]
         
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "")
        fetchedResultsController.delegate = (self as NSFetchedResultsControllerDelegate)

         do {
             try fetchedResultsController.performFetch()
         } catch {
            showAlert(title: "Failed to load saved lists", message: error.localizedDescription)
         }
     }
    
//    MARK: - View Functions
     
     override func viewDidLoad() {
         super.viewDidLoad()

         navigationItem.title = notebook.name
         navigationItem.rightBarButtonItem = editButtonItem
         
         setupFetchedResultsController()
         
         updateEditButtonState()
     }

     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         setupFetchedResultsController()
         if let indexPath = tableView.indexPathForSelectedRow {
             tableView.deselectRow(at: indexPath, animated: false)
             tableView.reloadRows(at: [indexPath], with: .fade)
         }
     }
     
     override func viewDidDisappear(_ animated: Bool) {
         super.viewDidDisappear(animated)
         fetchedResultsController = nil
     }

     // MARK: - Class Methods

     // Adds a new `Fact` to the end of the `notebook`'s `facts` array
     func addFact() {
         let fact = Fact(context: dataController.viewContext)
         fact.creationDate = Date()
         fact.toNotebook = notebook
         try? dataController.viewContext.save()
     }

     // Deletes the `Note` at the specified index path
     func deleteFact(at indexPath: IndexPath) {
         let factToDelete = fetchedResultsController.object(at: indexPath)
         dataController.viewContext.delete(factToDelete)
         try? dataController.viewContext.save()
     }

     func updateEditButtonState() {
        navigationItem.rightBarButtonItem?.isEnabled = fetchedResultsController.sections![0].numberOfObjects > 0
     }

     override func setEditing(_ editing: Bool, animated: Bool) {
         super.setEditing(editing, animated: animated)
         tableView.setEditing(editing, animated: animated)
     }

    
    
    // -------------------------------------------------------------------------
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[0].numberOfObjects ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FactCell.defaultReuseIdentifier, for: indexPath) as! FactCell

        let aFact = fetchedResultsController.object(at: indexPath)

        // Configure cell
        cell.factLabel.text = aFact.text
        
        if let creationDate = aFact.creationDate {
            cell.dateLabel.text = dateFormatter.string(from: creationDate)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: deleteFact(at: indexPath)
        default: () // Unsupported
        }
    }
    
    
    // -------------------------------------------------------------------------
       // MARK: - Segue

       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let viewController = segue.destination as? FactDetailsViewController {
               if let indexPath = tableView.indexPathForSelectedRow {
                   viewController.fact = fetchedResultsController.object(at: indexPath)
                   viewController.dataController = dataController

                   viewController.onDelete = { [weak self] in
                       if let indexPath = self?.tableView.indexPathForSelectedRow {
                           self?.deleteFact(at: indexPath)
                           self?.navigationController?.popViewController(animated: true)
                       }
                   }
               }
           }
       }
    
    
}


extension FactsListViewController:NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .fade)
                break
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .fade)
                break
            case .update:
                tableView.reloadRows(at: [indexPath!], with: .fade)
            case .move:
                tableView.moveRow(at: indexPath!, to: newIndexPath!)
            @unknown default:
                fatalError()
            }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
            case .insert: tableView.insertSections(indexSet, with: .fade)
            case .delete: tableView.deleteSections(indexSet, with: .fade)
            case .update, .move:
                fatalError("Invalid change type in controller(_:didChange:atSectionIndex:for:). Only .insert or .delete should be possible.")
            @unknown default:
                fatalError()
            }
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}
