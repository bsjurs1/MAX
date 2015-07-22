//
//  ExerciseRoutineTableViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 22.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit
import CoreData

class ExerciseRoutineTableViewController : UITableViewController, NSFetchedResultsControllerDelegate {
    
    var newExerciseRoutine : ExerciseRoutine?
    var managedObjectContext = NSManagedObjectContext()
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var fetchedResultsController : NSFetchedResultsController?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clearColor()
        
        newExerciseRoutine = NSEntityDescription.insertNewObjectForEntityForName("ExerciseRoutine", inManagedObjectContext: managedObjectContext) as? ExerciseRoutine

        
        let exercisesFetchRequest = NSFetchRequest(entityName: "RoutineExercise")
        let primarySortDescriptor = NSSortDescriptor(key: "exerciseNr", ascending: true)
        exercisesFetchRequest.sortDescriptors = [primarySortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: exercisesFetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: "isKindOfExercise.sectionId", cacheName: nil)
        
        self.view.tintColor = appDelegate.maxTintColor
        
        var error: NSError? = nil
        if (fetchedResultsController!.performFetch(&error) == false) {
            print("An error occurred: \(error?.localizedDescription)")
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if newExerciseRoutine != nil {
            
            return newExerciseRoutine!.exercises.count
            
        }
        
        return 0
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    
    // Method added to only show non-empty cells in tableview
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("exerciseCell", forIndexPath: indexPath) as! UITableViewCell
        
        if cell.isKindOfClass(ExerciseTableViewCell){
            
            var downCastedCell = cell as! ExerciseTableViewCell
            
            setUpExerciseCell(downCastedCell, indexPath: indexPath)
        }
        else if cell.isKindOfClass(ExerciseEditTableViewCell) {
            
            var downCastedCell = cell as! ExerciseEditTableViewCell
            
            setUpExerciseEditCell(downCastedCell, indexPath: indexPath)
        }

        return cell
        
    }
    
    func setUpExerciseEditCell(cell : ExerciseEditTableViewCell, indexPath : NSIndexPath){
        
        let exercise = fetchedResultsController!.objectAtIndexPath(indexPath) as! Exercise
        
        var setsTableViewController: SetsTableViewController? = self.storyboard?.instantiateViewControllerWithIdentifier("setTableViewController") as? SetsTableViewController
        
        self.addChildViewController(setsTableViewController!)
        
        setsTableViewController?.view.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y+60, UIScreen.mainScreen().bounds.width, cell.contentView.bounds.size.height-60)
        
        cell.contentView.addSubview(setsTableViewController!.view)
        
        cell.exerciseDetailsButton.tintColor = appDelegate.maxTintColor
        cell.addSetButton.tintColor = appDelegate.maxTintColor
        cell.editExerciseButton.tintColor = appDelegate.maxTintColor
        
    }
    
    func setUpExerciseCell(cell : ExerciseTableViewCell, indexPath : NSIndexPath){
        
        let exercise = newExerciseRoutine!.exercises.allObjects[indexPath.row] as! RoutineExercise
        
        cell.backgroundColor = UIColor.clearColor()
        
        cell.exerciseImageView?.image = exercise.isKindOfExercise.getImage()
        cell.exerciseNameLabel?.text = "\(exercise.exerciseNr)"
        
    }
    
    func editExercise(button: UIButton){

        println("Edit clicked")
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return 100
        
    }
    
    
}
