//
//  CreateExerciseForLibraryViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 26.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class CreateExerciseForLibraryViewController: UIViewController {
    
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var chooseKindOfExerciseSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var addExerciseImageButton: UIButton!
    
    var parentNavigationController : UINavigationController?
    
    var appDelegate = AppDelegate()
    
    
    override func viewDidLoad() {
        
        parentNavigationController?.title = "Create exercise for the library"
        
        cancelButton.tintColor = appDelegate.maxTintColor
        doneButton.tintColor = appDelegate.maxTintColor
        
        
    }
    
    func addBlurredBackGround(){
    
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var beView = UIVisualEffectView(effect: blurEffect)
        beView.frame = UIScreen.mainScreen().bounds
        
        self.view.frame = UIScreen.mainScreen().bounds
        self.view.backgroundColor = UIColor.clearColor()
    
    }

    @IBAction func cancelExerciseCreation(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

}
