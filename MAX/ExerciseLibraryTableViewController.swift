//
//  ExerciseLibraryTableViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 22.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//+

import UIKit

class ExerciseLibraryTableViewController: ExerciseTableViewController {
    
    @IBOutlet weak var exerciseSearchBar: UISearchBar!

    
    let alphabetArray : [String] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s",
        "t","u","v","w","x","y","z"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        return fetchedResultsController.sectionIndexTitles
    }
    
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return fetchedResultsController.sectionIndexTitles[section] as? String
        
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
        var exerciseTapped = fetchedResultsController.objectAtIndexPath(indexPath) as! Exercise
        
        println(exerciseTapped)
        
        var exerciseDescription = self.storyboard?.instantiateViewControllerWithIdentifier("descriptionController") as? ExerciseDescriptionViewController
        
        exerciseDescription!.exerciseDescription = exerciseTapped.exerciseDescription
        
        exerciseDescription?.view.frame = CGRectMake(0, 0,UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var beView = UIVisualEffectView(effect: blurEffect)
        beView.frame = UIScreen.mainScreen().bounds
        
        exerciseDescription!.view.frame = UIScreen.mainScreen().bounds
        exerciseDescription!.view.backgroundColor = UIColor.clearColor()
        exerciseDescription!.view.insertSubview(beView, atIndex: 0)
        exerciseDescription!.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        
        self.presentViewController(exerciseDescription!, animated: true, completion: nil)
        
        println(indexPath.row)
        
    }
    
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