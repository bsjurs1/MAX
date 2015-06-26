//
//  ExerciseLibraryViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 26.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class ExerciseLibraryViewController: UIViewController {
    
    var appDelegate = AppDelegate()
    @IBOutlet weak var addExerciseButton: UIButton!
    
    
    override func viewDidLoad() {
        
        addExerciseButton.tintColor = appDelegate.maxTintColor
        setUpExerciseLibraryTableViewController()
        
    }
    
    func setUpExerciseLibraryTableViewController(){
        
        var exerciseLibraryViewController = self.storyboard?.instantiateViewControllerWithIdentifier("libraryTableViewController") as? ExerciseLibraryTableViewController
        
        self.addChildViewController(exerciseLibraryViewController!)
        
        self.view.addSubview(exerciseLibraryViewController!.view)
        
        exerciseLibraryViewController?.view.frame = CGRectMake(0, 44,UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height-44)
        
    }
    
    
    @IBAction func addExerciseToLibrary(sender: UIButton) {
        
        var contributeViewController = UIViewController()
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var beView = UIVisualEffectView(effect: blurEffect)
        beView.frame = UIScreen.mainScreen().bounds
        
        contributeViewController.view.frame = UIScreen.mainScreen().bounds
        contributeViewController.view.backgroundColor = UIColor.clearColor()
        contributeViewController.view.insertSubview(beView, atIndex: 0)
        contributeViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        
        self.presentViewController(contributeViewController, animated: true, completion: nil)
        
        
    }

}
