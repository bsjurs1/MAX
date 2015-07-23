//
//  ExerciseRoutineTableViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 22.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit
import CoreData

class ExerciseRoutineTableViewController : CoreDataTableViewController {
    
    var newExerciseRoutine : ExerciseRoutine?
    var managedObjectContext = NSManagedObjectContext()
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clearColor()
        
        newExerciseRoutine = NSEntityDescription.insertNewObjectForEntityForName("ExerciseRoutine", inManagedObjectContext: managedObjectContext) as? ExerciseRoutine

        
        let exercisesFetchRequest = NSFetchRequest(entityName: "RoutineExercise")
        exercisesFetchRequest.predicate = NSPredicate(format: "belongsToRoutine == %@", newExerciseRoutine!)
        let primarySortDescriptor = NSSortDescriptor(key: "exerciseNr", ascending: false)
        exercisesFetchRequest.sortDescriptors = [primarySortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: exercisesFetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        self.view.tintColor = appDelegate.maxTintColor
        
        var error: NSError? = nil
        if (fetchedResultsController!.performFetch(&error) == false) {
            print("An error occurred: \(error?.localizedDescription)")
        }
        
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
        
        let exercise = fetchedResultsController!.objectAtIndexPath(indexPath) as! RoutineExercise
        
        cell.backgroundColor = UIColor.clearColor()
        
        cell.exerciseImageView?.image = exercise.isKindOfExercise.getImage()
        cell.exerciseNameLabel?.text = exercise.isKindOfExercise.name
        
    }
    
    func editExercise(button: UIButton){

        println("Edit clicked")
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return 100
        
    }
    
    
    /*
    // Override to support editing the table view.
    - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    [_managedObjectContext deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
    }
    }
    */
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            println(1)
            
            println(self.newExerciseRoutine)
            
            //[_managedObjectContext deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];

            managedObjectContext.deleteObject( self.fetchedResultsController!.objectAtIndexPath(indexPath) as! NSManagedObject)
            
            //var exerciseToDelete: RoutineExercise = self.newExerciseRoutine!.exercises.allObjects[indexPath.row] as! RoutineExercise
            
            //println(exerciseToDelete)
            
            //managedObjectContext.deleteObject(exerciseToDelete)
            
            println(2)
            
            tableView.reloadData()
            
            println(3)
            
            //self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            
            println(4)
            println(self.newExerciseRoutine)
            
        }
        
    }
    
}



