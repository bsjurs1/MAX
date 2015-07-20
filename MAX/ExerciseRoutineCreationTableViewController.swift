//
//  ExerciseRoutineCreationTableViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 20.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class ExerciseRoutineCreationTableViewController : ExerciseLibraryTableViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell : ExerciseProfileTableViewCell = tableView.dequeueReusableCellWithIdentifier("exerciseCell", forIndexPath: indexPath) as! ExerciseProfileTableViewCell
        
        let exercise = fetchedResultsController.objectAtIndexPath(indexPath) as! Exercise
        
        cell.backgroundColor = UIColor.clearColor()
        
        cell.exerciseImageView?.image = exercise.getImage()
        cell.exerciseNameLabel?.text = exercise.name
        cell.lastPerformanceDateLabel?.text = "Last performed 20.may.2015"
        
        return cell
        
    }
    
    override func viewDidLoad() {
        
        self.tableView.backgroundColor = UIColor.clearColor()
        
    }
    
    
}
