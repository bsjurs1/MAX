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
    
    @IBOutlet weak var addRoutineImageButton: UIButton!
    @IBOutlet weak var dragStaticLabel: UILabel!
    @IBOutlet weak var routineNameTextField: UITextField!
    
    var selectedCell = UIView()
    
    override func viewDidLoad() {
        
        self.view.tintColor = appDelegate.maxTintColor
        self.navigationController?.navigationBar.tintColor = appDelegate.maxTintColor
        self.addRoutineImageButton.tintColor = appDelegate.maxTintColor
        
        addExerciseLibraryViewController()
        
        setUpButtons()
        
        addNewRoutineTableViewController()
        
    }
    
    func addNewRoutineTableViewController(){
        
        
        
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
            
            var index = exerciseLibraryViewController!.exerciseLibraryTableViewController?.tableView.indexPathForCell(cell!)
            exerciseLibraryViewController!.exerciseLibraryTableViewController?.tableView.scrollEnabled = false
            
            if(index != nil){
                
                UIGraphicsBeginImageContext(cell!.contentView.bounds.size);
                cell!.contentView.layer.renderInContext(UIGraphicsGetCurrentContext())
                var img = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                var imageView = UIImageView(image: img)
                
                selectedCell.frame = imageView.frame
                selectedCell.addSubview(imageView)
                selectedCell.backgroundColor = UIColor.orangeColor()
                selectedCell.center = recognizer.locationInView(self.view)
                
                selectedCell.addGestureRecognizer(recognizer)
                
                self.view.addSubview(selectedCell)
            }
            
            break
        case UIGestureRecognizerState.Changed:
            
            selectedCell.center = recognizer.locationInView(self.view)
            
            break
        case UIGestureRecognizerState.Ended:
            
            if(recognizer.locationInView(self.view).y < exerciseLibraryViewController?.view.frame.origin.y ){
                dragStaticLabel.hidden = true
            }
            
            break
        default:
            break
            
        }
        
        /*UITableViewCell *cell= (UITableViewCell *)[gesture view];
        
        switch ([gesture state]) {
        case UIGestureRecognizerStateBegan:{
        NSIndexPath *ip = [self.tableView indexPathForCell:cell];
        [self.tableView setScrollEnabled:NO];
        
        
        if(ip!=nil){
        [self.draggableDelegate dragAndDropTableViewController:self  draggingGestureWillBegin:gesture forCell:cell];
        UIView *draggedView = [self.draggableDelegate dragAndDropTableViewControllerView:self ];
        //switch the view the gesture is associated with this will allow the dragged view to continue on where the cell leaves off from
        [draggedView addGestureRecognizer:[[cell gestureRecognizers]objectAtIndex:0]];
        [self.draggableDelegate dragAndDropTableViewController:self draggingGestureDidBegin:gesture forCell:cell];
        }
        
        
        }
        break;
        case UIGestureRecognizerStateChanged:{
        [self.draggableDelegate dragAndDropTableViewController:self draggingGestureDidMove:gesture];
        }
        break;
        case UIGestureRecognizerStateEnded:{
        UIView *draggedView = [self.draggableDelegate dragAndDropTableViewControllerView:self];
        if(draggedView==nil)
        return;
        
        //this does not seem like the best way to do this yet you really don't want to fire one after the other I don't think
        [self.draggableDelegate dragAndDropTableViewController:self draggingGestureDidEnd:gesture];
        [self.dropableDelegate dragAndDropTableViewController:self droppedGesture:gesture];
        
        [self.tableView setScrollEnabled:YES];
        [self.tableView reloadData];
        }
        break;
        
        //        case UIGestureRecognizerStateCancelled:
        //        case UIGestureRecognizerStateFailed:
        //        case UIGestureRecognizerStatePossible:
        //            [self.dragAndDropDelegate dragAndDropTableViewController:self draggingGesture:gesture endedForItem:nil];
        break;
        default:
        break;
        */
        
    }


    
    
    
    

}
