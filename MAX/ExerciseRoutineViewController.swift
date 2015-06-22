//
//  ExerciseRoutineViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 22.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class ExerciseRoutineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var appDelegate = AppDelegate()
    
    var sSampleArray : [String] = ["Squats"]
    var samplePicArray : [String] = ["squats.png"]
    
    @IBOutlet weak var startTrainingToolBarButton: UIBarButtonItem!
    @IBOutlet weak var exerciseRoutineTableView: UITableView!
    
    override func viewDidLoad() {
        
        setBarButtons()
        
        self.navigationItem.title = "Leg day"
        
        self.view.tintColor = appDelegate.maxTintColor
        
    }
    
    func setBarButtons(){
        
        var editExerciseBarButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: "editExercise")

        editExerciseBarButton.tintColor = appDelegate.maxTintColor
        
        var addExerciseBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addExercise")
        
        addExerciseBarButtonItem.tintColor = appDelegate.maxTintColor
        
        self.navigationItem.rightBarButtonItems = [addExerciseBarButtonItem, editExerciseBarButton]
        
        startTrainingToolBarButton.tintColor = appDelegate.maxTintColor
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell : ExerciseTableViewCell = exerciseRoutineTableView.dequeueReusableCellWithIdentifier("exerciseRoutineCell", forIndexPath: indexPath) as! ExerciseTableViewCell
        
        cell.exerciseImageView?.image = UIImage(named: samplePicArray[0])
        cell.exerciseNameLabel?.text = sSampleArray[0]
        
        return cell
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
        
    }
    
    func addExercise(){
        
    }
    
    func editExercise(){
        
        
    }

}
