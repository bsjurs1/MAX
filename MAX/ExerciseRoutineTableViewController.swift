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
    var selectedExerciseIndex : NSIndexPath?
    var doneClicked = false
    
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
        
        if(indexPath == selectedExerciseIndex && doneClicked == true){
            
            let exercise = fetchedResultsController!.objectAtIndexPath(indexPath) as! RoutineExercise
            var cell : ExerciseEditTableViewCell = tableView.dequeueReusableCellWithIdentifier("exerciseEditCell", forIndexPath: indexPath) as! ExerciseEditTableViewCell
            
            cell.backgroundColor = UIColor.clearColor()
            
            cell.exerciseNameLabel.text = exercise.isKindOfExercise.name
            cell.exerciseImageView.image = exercise.isKindOfExercise.getImage()
            cell.exerciseDetailsButton.addTarget(self, action: "showExerciseInformation", forControlEvents: UIControlEvents.TouchUpInside)
            cell.addSetButton.addTarget(self, action: "addSet", forControlEvents: UIControlEvents.TouchUpInside)
            cell.managedObjectContext = self.managedObjectContext
            cell.exercise = exercise
            cell.isRepetitionExercise = true
            cell.setupFetchedResultsController()
            
            return cell
            
        }
        else{
        
            var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("exerciseCell", forIndexPath: indexPath) as! UITableViewCell
        
            if cell.isKindOfClass(ExerciseTableViewCell){
            
                var downCastedCell = cell as! ExerciseTableViewCell
            
                setUpExerciseCell(downCastedCell, indexPath: indexPath)
            }

            return cell
            
        }
        
    }
    
    func addSet(){
        
        var newSet = NSEntityDescription.insertNewObjectForEntityForName("RepetitionSet", inManagedObjectContext: managedObjectContext) as! RepetitionSet
        
        newSet.setNr = 1
        
        var exercise = fetchedResultsController?.objectAtIndexPath(selectedExerciseIndex!) as! RepetitionRoutineExercise
        
        newSet.belongsToExercise = exercise
        
    }
    
    func showExerciseInformation(){
        
        var routineExerciseTapped = fetchedResultsController!.objectAtIndexPath(selectedExerciseIndex!) as! RoutineExercise
        
        var exerciseTapped = routineExerciseTapped.isKindOfExercise
        
        println(exerciseTapped)
        
        var exerciseDescription = self.storyboard?.instantiateViewControllerWithIdentifier("descriptionController") as? ExerciseDescriptionViewController
        
        exerciseDescription?.exerciseDescription = exerciseTapped.exerciseDescription
        
        exerciseDescription?.exerciseImage = exerciseTapped.getImage()
        
        exerciseDescription?.view.frame = CGRectMake(0, 0,UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var beView = UIVisualEffectView(effect: blurEffect)
        beView.frame = UIScreen.mainScreen().bounds
        
        exerciseDescription!.view.frame = UIScreen.mainScreen().bounds
        exerciseDescription!.view.backgroundColor = UIColor.clearColor()
        exerciseDescription!.view.insertSubview(beView, atIndex: 0)
        exerciseDescription!.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        
        self.presentViewController(exerciseDescription!, animated: true, completion: nil)

        
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

        if(indexPath == selectedExerciseIndex && doneClicked == true){
            
            return 300
            
        }
        else {
        
            return 100
            
        }
        
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        if selectedExerciseIndex != nil && indexPath == selectedExerciseIndex! {
            
            selectedExerciseIndex = nil
            
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
        }
        
        else if selectedExerciseIndex != nil && indexPath != selectedExerciseIndex {

            var previouslySelectedCell = selectedExerciseIndex!
            
            selectedExerciseIndex = indexPath
            
            tableView.reloadRowsAtIndexPaths([previouslySelectedCell, selectedExerciseIndex!], withRowAnimation: UITableViewRowAnimation.Fade)

 
        }
        
        else {
            
            selectedExerciseIndex = indexPath
            
            
            tableView.reloadRowsAtIndexPaths([selectedExerciseIndex!], withRowAnimation: UITableViewRowAnimation.Fade)
            
            
        }
        
        return indexPath
        
    }
    
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



