//
//  ExerciseRoutineTableViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 22.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit
import CoreData

class ExerciseRoutineTableViewController : ExerciseTableViewController{
    
    var newExerciseRoutine : ExerciseRoutine?
    var managedObjectContext = NSManagedObjectContext()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        managedObjectContext = appDelegate.managedObjectContext!
        
        newExerciseRoutine = NSEntityDescription.insertNewObjectForEntityForName("ExerciseRoutine", inManagedObjectContext: managedObjectContext) as? ExerciseRoutine
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if newExerciseRoutine != nil {
            
            return newExerciseRoutine!.exercisesInNewRoutine.count
            
        }
        
        return 0
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
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
        
        let exercise = fetchedResultsController.objectAtIndexPath(indexPath) as! Exercise
        
        var setsTableViewController: SetsTableViewController? = self.storyboard?.instantiateViewControllerWithIdentifier("setTableViewController") as? SetsTableViewController
        
        self.addChildViewController(setsTableViewController!)
        
        setsTableViewController?.view.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y+60, UIScreen.mainScreen().bounds.width, cell.contentView.bounds.size.height-60)
        
        cell.contentView.addSubview(setsTableViewController!.view)
        
        cell.exerciseDetailsButton.tintColor = appDelegate.maxTintColor
        cell.addSetButton.tintColor = appDelegate.maxTintColor
        cell.editExerciseButton.tintColor = appDelegate.maxTintColor
        
    }
    
    func setUpExerciseCell(cell : ExerciseTableViewCell, indexPath : NSIndexPath){
        
        let exercise = newExerciseRoutine!.exercisesInNewRoutine.allObjects[indexPath.row] as! Exercise
        
        cell.backgroundColor = UIColor.clearColor()
        
        cell.exerciseImageView?.image = exercise.getImage()
        cell.exerciseNameLabel?.text = exercise.name
        
    }
    
    func editExercise(button: UIButton){

        println("Edit clicked")
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return 100
        
    }
    
    
}
