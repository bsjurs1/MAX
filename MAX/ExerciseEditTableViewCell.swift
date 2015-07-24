//
//  ExerciseEditTableViewCell.swift
//  MAX
//
//  Created by Bjarte Sjursen on 24.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit
import CoreData

class ExerciseEditTableViewCell: UITableViewCell, NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var appDelegate = AppDelegate()
    var usedByViewController = ExerciseRoutineTableViewController()
    
    @IBOutlet weak var exerciseDetailsButton: UIButton!
    @IBOutlet weak var addSetButton: UIButton!
    @IBOutlet weak var editExerciseButton: UIButton!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var setsTableView: UITableView!
    var isRepetitionExercise : Bool?
    var exercise : RoutineExercise?
    var managedObjectContext : NSManagedObjectContext?

    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(isRepetitionExercise == true){
            
            var set = fetchedResultsController?.objectAtIndexPath(indexPath) as! RepetitionSet
            
            var cell : EditExerciseSetTableViewCell = tableView.dequeueReusableCellWithIdentifier("setCell", forIndexPath: indexPath) as! EditExerciseSetTableViewCell
            
            cell.backgroundColor = UIColor.clearColor()
            
            cell.repetitionsTextField.tintColor = UIColor.orangeColor()
            cell.weightTextField.tintColor = UIColor.orangeColor()
            
            cell.setNumberLabel.text = "\(set.setNr)"
            cell.addDoneButtonToNumpads()
            cell.set = set
            if (set.numberOfRepetitions.intValue != 0) {
                 cell.repetitionsTextField.text = "\(set.numberOfRepetitions.intValue)"
            }
            if (set.weightToLift.doubleValue != 0){
                cell.weightTextField.text = "\(set.weightToLift.doubleValue)"
            }
            
            return cell
        }
        else {
            
            // add code to handle time sets
            
            var cell : EditExerciseSetTableViewCell = tableView.dequeueReusableCellWithIdentifier("setCell", forIndexPath: indexPath) as! EditExerciseSetTableViewCell
            
            cell.setNumberLabel.text = "Set 1"
            
            return cell
            
        }

        
    }
    
    func setupFetchedResultsController(){
        
        self.setsTableView.dataSource = self
        self.setsTableView.delegate = self
        
        let exercisesFetchRequest = NSFetchRequest(entityName: "RepetitionSet")
        exercisesFetchRequest.predicate = NSPredicate(format: "belongsToExercise == %@", exercise!)
        let primarySortDescriptor = NSSortDescriptor(key: "setNr", ascending: true)
        exercisesFetchRequest.sortDescriptors = [primarySortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: exercisesFetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        setsTableView.backgroundColor = UIColor.clearColor()
        
        var error: NSError? = nil
        if (fetchedResultsController!.performFetch(&error) == false) {
            print("An error occurred: \(error?.localizedDescription)")
        }

        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var fetchedResultsController: NSFetchedResultsController? {
        didSet {
            self.setUpFetchedResultsController()
        }
    }
    
    // MARK: - Fetching
    
    func performFetch() {
        var error: NSError?
        self.fetchedResultsController!.performFetch(&error)
        if let err = error {
            NSLog("%@", err.localizedDescription)
        }
        self.setsTableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController!.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if self.fetchedResultsController!.sections!.count > 0 {
            var sectionInfo = self.fetchedResultsController!.sections![section] as! NSFetchedResultsSectionInfo
            rows = sectionInfo.numberOfObjects
        }
        return rows
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionInfo = self.fetchedResultsController!.sections![section] as! NSFetchedResultsSectionInfo
        return sectionInfo.name
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return self.fetchedResultsController!.sectionForSectionIndexTitle(title, atIndex: index)
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        return self.fetchedResultsController!.sectionIndexTitles
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.setsTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.setsTableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        let indexSet = NSIndexSet(index: sectionIndex)
        switch type {
        case NSFetchedResultsChangeType.Insert:
            self.setsTableView.insertSections(indexSet, withRowAnimation: UITableViewRowAnimation.Fade)
        case NSFetchedResultsChangeType.Delete:
            self.setsTableView.deleteSections(indexSet, withRowAnimation: UITableViewRowAnimation.Fade)
        case NSFetchedResultsChangeType.Update:
            break
        case NSFetchedResultsChangeType.Move:
            break
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case NSFetchedResultsChangeType.Insert:
            self.setsTableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        case NSFetchedResultsChangeType.Delete:
            self.setsTableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        case NSFetchedResultsChangeType.Update:
            self.setsTableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        case NSFetchedResultsChangeType.Move:
            self.setsTableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            self.setsTableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    // MARK: - Private
    private func setUpFetchedResultsController() {
        self.fetchedResultsController!.delegate = self
        self.performFetch()
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            managedObjectContext!.deleteObject(self.fetchedResultsController!.objectAtIndexPath(indexPath) as! NSManagedObject)
            
        }
        
    }
    

}
