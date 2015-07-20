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
    
    override func viewDidLoad() {
        
        self.view.tintColor = appDelegate.maxTintColor
        self.navigationController?.navigationBar.tintColor = appDelegate.maxTintColor
        self.addRoutineImageButton.tintColor = appDelegate.maxTintColor
        
        setUpButtons()
        
        addExerciseLibraryViewController()
        
    }
    
    func addExerciseLibraryViewController(){
        
        exerciseLibraryViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("exerciseLibraryViewController") as? ExerciseLibraryViewController)!
        
        self.addChildViewController(exerciseLibraryViewController!)
    
        exerciseLibraryViewController!.view.frame = CGRectMake(0, (UIScreen.mainScreen().bounds.size.height/2) ,UIScreen.mainScreen().bounds.size.width, (UIScreen.mainScreen().bounds.size.height/2))
        
        
        var gestureRecognizer =  UIPanGestureRecognizer(target: self, action: "moveView:")
        
        gestureRecognizer.maximumNumberOfTouches = 1
        
        exerciseLibraryViewController!.view.addGestureRecognizer(gestureRecognizer)
        
        self.view.addSubview(exerciseLibraryViewController!.view)

        
        setUpButtons()
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


    
    
    
    

}
