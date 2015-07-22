//
//  CreateRoutineViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 26.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit
import CoreData

class CreateRoutineViewController: UIViewController, UITextFieldDelegate {
    
    var appDelegate = AppDelegate()
    
    var exerciseLibraryViewController : ExerciseLibraryViewController?
    var exerciseRoutineTableViewController : ExerciseRoutineTableViewController?
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var addRoutineImageButton: UIButton!
    @IBOutlet weak var dragStaticLabel: UILabel!
    @IBOutlet weak var routineNameTextField: UITextField!
    var index : NSIndexPath?
    var exerciseNr = 1
    var prevPositionOfLibraryView = CGFloat()
    var doneClicked = false
    var lineView = UIView()
    
    var selectedCell : UIView?
    
    override func viewDidLoad() {
        
        self.doneButton.enabled = false
        
        self.routineNameTextField.delegate = self
        
        self.view.tintColor = appDelegate.maxTintColor
        self.navigationController?.navigationBar.tintColor = appDelegate.maxTintColor
        self.addRoutineImageButton.tintColor = appDelegate.maxTintColor
        
        addExerciseLibraryViewController()
        
        addExerciseRoutineTableViewController()
        
        setUpButtons()
        
        addLineView()
        
    }
    
    func addLineView(){
        
        lineView.frame = CGRectMake(20, 110, UIScreen.mainScreen().bounds.size.width-40, 1)
        lineView.backgroundColor = UIColor(red: 0.6471, green: 0.6471, blue: 0.6471, alpha: 0.6)
        self.view.addSubview(lineView)
        self.view.sendSubviewToBack(lineView)
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        prevPositionOfLibraryView = self.exerciseLibraryViewController!.view.frame.origin.y
        
        UIView.animateWithDuration(0.2, animations: {
        
            self.exerciseLibraryViewController!.view.frame.origin.y = UIScreen.mainScreen().bounds.size.height-200
            
        })
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        routineNameTextField.resignFirstResponder()
        
        UIView.animateWithDuration(0.2, animations: {
            
            self.exerciseLibraryViewController!.view.frame.origin.y = self.prevPositionOfLibraryView
            
        })

        
        return true
        
    }
    
    func addExerciseRoutineTableViewController(){
        
        exerciseRoutineTableViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("exerciseTableViewController") as? ExerciseRoutineTableViewController)!
        
        exerciseRoutineTableViewController?.managedObjectContext = exerciseLibraryViewController!.exerciseLibraryTableViewController!.managedContext
        
        self.addChildViewController(exerciseLibraryViewController!)
        
        exerciseRoutineTableViewController!.view.frame = CGRectMake(0, 110,UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - 100)

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
        
        if(doneClicked){
            
            doneClicked = false
            
            UIView.animateWithDuration(0.2, animations: {
                
                self.exerciseLibraryViewController!.view.frame.origin.y = UIScreen.mainScreen().bounds.size.height/2
                
                self.exerciseLibraryViewController!.view.frame.size.height = UIScreen.mainScreen().bounds.size.height/2

                self.routineNameTextField.frame.origin.y += 100
                self.addRoutineImageButton.frame.origin.y += 100
                self.exerciseRoutineTableViewController!.view.frame.origin.y += 50
                self.exerciseRoutineTableViewController!.view.frame.size.height -= 40
                
                self.exerciseLibraryViewController?.addExerciseButton.enabled = true
                
                self.lineView.frame.origin.y += 100
                
                self.navigationItem.title = "Create new routine"
                
            })
        }
        
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
            } else {
                
                selectedCell!.removeFromSuperview()
                selectedCell = nil
                exerciseLibraryViewController!.exerciseLibraryTableViewController?.tableView.scrollEnabled = true

                
            }
            
            exerciseLibraryViewController!.exerciseLibraryTableViewController!.tableView.reloadData()
            
            break
        default:
            break
            
        }
        
    }
    
    func addExerciseToNewRoutine(indexPath : NSIndexPath){
        
        var newRoutine = exerciseRoutineTableViewController?.newExerciseRoutine
        
        var exerciseData = exerciseLibraryViewController!.exerciseLibraryTableViewController?.fetchedResultsController.objectAtIndexPath(indexPath) as! Exercise
        
        var newRoutineExercise = NSEntityDescription.insertNewObjectForEntityForName("RoutineExercise", inManagedObjectContext: self.exerciseLibraryViewController!.exerciseLibraryTableViewController!.managedContext) as! RoutineExercise
        
        newRoutineExercise.isKindOfExercise = exerciseData
        newRoutineExercise.exerciseNr = exerciseNr++
        
        newRoutine?.setValue(newRoutine?.exercises.setByAddingObject(newRoutineExercise), forKey: "exercises")
        
        exerciseRoutineTableViewController!.tableView.reloadData()
        
        
        if(doneButton.enabled == false){
            UIView.animateWithDuration(0.2, animations: {
            
                self.doneButton.enabled = true
            
            })
        }
        
  
    }
    
    @IBAction func doneAddingExercises(sender: AnyObject) {
        
        doneClicked = true
        
        UIView.animateWithDuration(0.2, animations: {
            
            self.exerciseLibraryViewController!.view.frame.origin.y = UIScreen.mainScreen().bounds.size.height-40
            
            self.routineNameTextField.frame.origin.y -= 100
            self.addRoutineImageButton.frame.origin.y -= 100
            self.exerciseRoutineTableViewController!.view.frame.origin.y -= 50
            self.exerciseRoutineTableViewController!.view.frame.size.height += 40
            
            self.exerciseLibraryViewController?.addExerciseButton.enabled = false
            
            self.navigationItem.title = self.routineNameTextField.text
            
            self.lineView.frame.origin.y -= 100
        })
        
        
        self.exerciseLibraryViewController?.exerciseLibraryTableViewController?.managedContext.save(nil)
        
        
        
        
    }
    


    
    
    
    

}
