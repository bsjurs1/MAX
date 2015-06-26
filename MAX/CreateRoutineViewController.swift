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
    
    override func viewDidLoad() {
        
        self.view.tintColor = appDelegate.maxTintColor
        self.navigationController?.navigationBar.tintColor = appDelegate.maxTintColor
        
        addExerciseLibraryViewController()
        
    }
    
    func addExerciseLibraryViewController(){
        
        var exerciseLibraryViewController = self.storyboard?.instantiateViewControllerWithIdentifier("exerciseLibraryViewController") as? ExerciseLibraryViewController
        
        self.addChildViewController(exerciseLibraryViewController!)
        
        self.view.addSubview(exerciseLibraryViewController!.view)
    
        exerciseLibraryViewController?.view.frame = CGRectMake(0, (UIScreen.mainScreen().bounds.size.height/2) ,UIScreen.mainScreen().bounds.size.width, (UIScreen.mainScreen().bounds.size.height/2))
        
        
        
        
    }

    
    
    
    

}
