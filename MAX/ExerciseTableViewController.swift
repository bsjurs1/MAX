//
//  ExerciseTableViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 21.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit
import CoreData

class ExerciseTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var sSampleArray : [String] = ["Squats", "Sit-ups"]
    var samplePicArray : [String] = ["squats.png", "situp.jpg"]
    var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var fetchedResultsController = NSFetchedResultsController()
    var managedContext = NSManagedObjectContext()
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.clearColor()
        
        managedContext = appDelegate.managedObjectContext!
        
        let exercisesFetchRequest = NSFetchRequest(entityName: "Exercise")
        let primarySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        exercisesFetchRequest.sortDescriptors = [primarySortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: exercisesFetchRequest, managedObjectContext: self.managedContext, sectionNameKeyPath: "sectionId", cacheName: nil)
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Exercises"
        
        self.view.tintColor = appDelegate.maxTintColor
        
        var error: NSError? = nil
        if (fetchedResultsController.performFetch(&error) == false) {
            print("An error occurred: \(error?.localizedDescription)")
        }
        
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        
        return 0
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = fetchedResultsController.sections {
            let currentSection = sections[section] as! NSFetchedResultsSectionInfo
            return currentSection.numberOfObjects
        }
        
        return 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell : ExerciseProfileTableViewCell = tableView.dequeueReusableCellWithIdentifier("exerciseCell", forIndexPath: indexPath) as! ExerciseProfileTableViewCell
        
        let exercise = fetchedResultsController.objectAtIndexPath(indexPath) as! Exercise
        
        cell.backgroundColor = UIColor.clearColor()
        
        //cell.exerciseImageView?.image = UIImage(named: samplePicArray[indexPath.row])
        cell.exerciseNameLabel?.text = exercise.name
        cell.lastPerformanceDateLabel?.text = "Last performed 20.may.2015"

        return cell
        
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
