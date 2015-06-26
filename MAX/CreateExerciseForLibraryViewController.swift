//
//  CreateExerciseForLibraryViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 26.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class CreateExerciseForLibraryViewController: UIViewController {
    
    
    @IBOutlet weak var chooseKindOfExerciseSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var addExerciseImageButton: UIButton!
    
    var appDelegate = AppDelegate()
    
    
    override func viewDidLoad() {
        
        self.navigationController?.navigationItem.title = "Create new exercise for library"
        
        //chooseKindOfExerciseSegmentedControl.tintColor = appDelegate.maxTintColor
        
        //chooseKindOfExerciseSegmentedControl.tintColor = appDelegate.maxTintColor
        
        
    }
    
    func addBlurredBackGround(){
    
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var beView = UIVisualEffectView(effect: blurEffect)
        beView.frame = UIScreen.mainScreen().bounds
        
        self.view.frame = UIScreen.mainScreen().bounds
        self.view.backgroundColor = UIColor.clearColor()
    
    }

}
