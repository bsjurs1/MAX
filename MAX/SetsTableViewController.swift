//
//  SetsTableViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 24.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class SetsTableViewController: UITableViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : EditExerciseSetTableViewCell = tableView.dequeueReusableCellWithIdentifier("setCell", forIndexPath: indexPath) as! EditExerciseSetTableViewCell
        
        cell.setNumberLabel.text = "Set 1"
        
        return cell
        
        
    }

}
