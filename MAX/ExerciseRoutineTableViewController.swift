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
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController!.sections!.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if self.fetchedResultsController!.sections!.count > 0 {
            var sectionInfo = self.fetchedResultsController!.sections![section] as! NSFetchedResultsSectionInfo
            rows = sectionInfo.numberOfObjects
        }
        return rows
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionInfo = self.fetchedResultsController!.sections![section] as! NSFetchedResultsSectionInfo
        return sectionInfo.name
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return self.fetchedResultsController!.sectionForSectionIndexTitle(title, atIndex: index)
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        return self.fetchedResultsController!.sectionIndexTitles
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        let indexSet = NSIndexSet(index: sectionIndex)
        switch type {
        case NSFetchedResultsChangeType.Insert:
            self.tableView.insertSections(indexSet, withRowAnimation: UITableViewRowAnimation.Fade)
        case NSFetchedResultsChangeType.Delete:
            self.tableView.deleteSections(indexSet, withRowAnimation: UITableViewRowAnimation.Fade)
        case NSFetchedResultsChangeType.Update:
            break
        case NSFetchedResultsChangeType.Move:
            break
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case NSFetchedResultsChangeType.Insert:
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        case NSFetchedResultsChangeType.Delete:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        case NSFetchedResultsChangeType.Update:
            self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        case NSFetchedResultsChangeType.Move:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    // MARK: - Private
    
    private func setUpFetchedResultsController() {
        self.fetchedResultsController!.delegate = self
        if self.title == nil && (self.navigationController == nil || self.navigationItem.title == nil) {
            self.title = self.fetchedResultsController!.fetchRequest.entity!.name
        }
        self.performFetch()
    }
}



