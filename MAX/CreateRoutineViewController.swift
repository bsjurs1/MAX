//
//  CreateRoutineViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 26.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class CreateRoutineViewController: UIViewController {
    
    var appDelegate = AppDelegate()
    
    var exerciseLibraryViewController : ExerciseLibraryViewController?
    var exerciseRoutineTableViewController : ExerciseRoutineTableViewController?
    
    @IBOutlet weak var addRoutineImageButton: UIButton!
    @IBOutlet weak var dragStaticLabel: UILabel!
    @IBOutlet weak var routineNameTextField: UITextField!
    var index : NSIndexPath?
    
    var selectedCell : UIView?
    
    override func viewDidLoad() {
        
        self.view.tintColor = appDelegate.maxTintColor
        self.navigationController?.navigationBar.tintColor = appDelegate.maxTintColor
        self.addRoutineImageButton.tintColor = appDelegate.maxTintColor
        
        addExerciseLibraryViewController()
        
        addExerciseRoutineTableViewController()
        
        setUpButtons()
        
    }
    
    func addExerciseRoutineTableViewController(){
        
        exerciseRoutineTableViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("exerciseTableViewController") as? ExerciseRoutineTableViewController)!
        
        self.addChildViewController(exerciseLibraryViewController!)
        
        exerciseRoutineTableViewController!.view.frame = CGRectMake(0, 100,UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - 100)

        self.view.insertSubview(exerciseRoutineTableViewController!.view, belowSubview: exerciseLibraryViewController!.view)
        
    }

    
    func addExerciseLibraryViewController(){
        
        exerciseLibraryViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("exerciseLibraryViewController") as? ExerciseLibraryViewController)!
        
        self.addChildViewController(exerciseLibraryViewController!)
    
        exerciseLibraryViewController!.view.frame = CGRectMake(0, (UIScreen.mainScreen().bounds.size.height/2) ,UIScreen.mainScreen().bounds.size.width, (UIScreen.mainScreen().bounds.size.height/2))
        
        
        var gestureRecognizer =  UIPanGestureRecognizer(target: self, action: "moveView:")
        
        gestureRecognizer.maximumNumberOfTouches = 1
        
        exerciseLibraryViewController!.view.addGestureRecognizer(gestureRecognizer)
        
        self.view.addSubview(exerciseLibraryViewController!.view)
        
        exerciseLibraryViewController?.exerciseLibraryTableViewController?.parentView = self

    }
    
    func setUpButtons(){
        
        self.view.insertSubview(dragStaticLabel, belowSubview: exerciseLibraryViewController!.view)
        self.view.insertSubview(routineNameTextField, belowSubview: exerciseLibraryViewController!.view)
        self.view.insertSubview(addRoutineImageButton, belowSubview: exerciseLibraryViewController!.view)
        
    }
    
    func moveView(gestureRecognizer : UIPanGestureRecognizer){
        
        var translation : CGPoint = gestureRecognizer.translationInView(self.view)
        
        gestureRecognizer.view?.center = CGPointMake((UIScreen.mainScreen().bounds.width/2), exerciseLibraryViewController!.view.center.y + translation.y)
        
        exerciseLibraryViewController!.view.frame.size.height = exerciseLibraryViewController!.view.frame.size.height - translation.y
        
        gestureRecognizer.setTranslation(CGPointMake(0,0), inView: self.view)
        
    }
    
    func moveCell(recognizer : UIPanGestureRecognizer){
        
        println("moving cell")
        
    }
    
    func longPressedCell(recognizer : UILongPressGestureRecognizer){
        
        var cell : ExerciseProfileTableViewCell?
        
        switch (recognizer.state){
            
        case UIGestureRecognizerState.Began:
            
            cell = recognizer.view as? ExerciseProfileTableViewCell
            
            index = exerciseLibraryViewController!.exerciseLibraryTableViewController?.tableView.indexPathForCell(cell!)
            exerciseLibraryViewController!.exerciseLibraryTableViewController?.tableView.scrollEnabled = false
            
            if(index != nil){
                
                UIGraphicsBeginImageContext(cell!.contentView.bounds.size)
                cell!.contentView.layer.renderInContext(UIGraphicsGetCurrentContext())
                var img = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                var imageView = UIImageView(image: img)
                
                selectedCell = UIView()
                selectedCell!.frame = imageView.frame
                selectedCell!.addSubview(imageView)
                selectedCell!.backgroundColor = UIColor.orangeColor()
                selectedCell!.center = recognizer.locationInView(self.view)
                selectedCell!.addGestureRecognizer(recognizer)
                
                self.view.addSubview(selectedCell!)
            }
            
            break
        case UIGestureRecognizerState.Changed:
            selectedCell!.center = recognizer.locationInView(self.view)
            break
        case UIGestureRecognizerState.Ended:
            
            if(recognizer.locationInView(self.view).y < exerciseLibraryViewController?.view.frame.origin.y ){
                dragStaticLabel.hidden = true
                selectedCell!.removeFromSuperview()
                selectedCell = nil
                exerciseLibraryViewController!.exerciseLibraryTableViewController?.tableView.scrollEnabled = true
                println("before")
                println(index!.row)
                addExerciseToNewRoutine(index!)
                println("after")
            }
            break
        default:
            break
            
        }
        
    }
    
    func addExerciseToNewRoutine(indexPath : NSIndexPath){
        
        var newRoutine = exerciseRoutineTableViewController?.newExerciseRoutine
        
        var exerciseToAdd = exerciseLibraryViewController!.exerciseLibraryTableViewController?.fetchedResultsController.objectAtIndexPath(indexPath) as! Exercise
        
        newRoutine?.setValue(newRoutine?.exercisesInNewRoutine.setByAddingObject(exerciseToAdd), forKey: "exercisesInNewRoutine")
        
        exerciseRoutineTableViewController!.tableView.reloadData()
  
    }



    
    
    
    

}
