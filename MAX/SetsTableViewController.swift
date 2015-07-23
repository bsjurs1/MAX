//
//  SetsTableViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 24.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit
import CoreData

class SetsTableViewController: CoreDataTableViewController {
    
    var exerciseToEdit : RoutineExercise?
    var appDelegate = AppDelegate()
    var managedObjectContext = NSManagedObjectContext()
    var isRepetitionExercise : Bool?
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(isRepetitionExercise == true){
            
            var set = fetchedResultsController?.objectAtIndexPath(indexPath) as! RepetitionSet
        
            var cell : EditExerciseSetTableViewCell = tableView.dequeueReusableCellWithIdentifier("setCell", forIndexPath: indexPath) as! EditExerciseSetTableViewCell
        
            cell.setNumberLabel.text = "\(set.setNr)"
        
            return cell
        }
        else {
            
            // add code to handle time sets
            
            var cell : EditExerciseSetTableViewCell = tableView.dequeueReusableCellWithIdentifier("setCell", forIndexPath: indexPath) as! EditExerciseSetTableViewCell
            
            cell.setNumberLabel.text = "Set 1"
            
            return cell
            
        }
        
        
    }
    
    override func viewDidLoad() {
        
        if(isRepetitionExercise == true){
            
            let exercisesFetchRequest = NSFetchRequest(entityName: "RepetitionSet")
            exercisesFetchRequest.predicate = NSPredicate(format: "belongsToExercise == %@", exerciseToEdit!)
            let primarySortDescriptor = NSSortDescriptor(key: "setNr", ascending: true)
            exercisesFetchRequest.sortDescriptors = [primarySortDescriptor]
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: exercisesFetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)

            
        }
        else if (isRepetitionExercise == false){
            
            let exercisesFetchRequest = NSFetchRequest(entityName: "TimeSet")
            exercisesFetchRequest.predicate = NSPredicate(format: "belongsToExercise == %@", exerciseToEdit!)
            let primarySortDescriptor = NSSortDescriptor(key: "setNr", ascending: true)
            exercisesFetchRequest.sortDescriptors = [primarySortDescriptor]
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: exercisesFetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            
        }
        
        self.view.tintColor = appDelegate.maxTintColor
    
        var error: NSError? = nil
        
        if (fetchedResultsController!.performFetch(&error) == false) {
            print("An error occurred: \(error?.localizedDescription)")
        }
    }
    
    

}
