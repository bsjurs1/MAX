//
//  ExerciseRoutineViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 22.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class ExerciseRoutineViewController: UIViewController {
    
    var appDelegate = AppDelegate()
    
    @IBOutlet weak var startTrainingToolBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        setBarButtons()
        
    }
    
    func setBarButtons(){
        
        var editExerciseBarButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: "editExercise:")

        editExerciseBarButton.tintColor = appDelegate.maxTintColor
        
        var addExerciseBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addExercise")
        
        addExerciseBarButtonItem.tintColor = appDelegate.maxTintColor
        
        self.navigationItem.rightBarButtonItems = [addExerciseBarButtonItem, editExerciseBarButton]
        
        startTrainingToolBarButton.tintColor = appDelegate.maxTintColor
        
    }
    
    func addExercise(){
        
    }
    
    func editExercise(){
        
        
    }

}
