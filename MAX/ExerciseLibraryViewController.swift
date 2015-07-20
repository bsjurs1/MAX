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
    var exerciseLibraryTableViewController : ExerciseLibraryTableViewController?
    
    var parentNavigationController : UINavigationController?
    
    
    override func viewDidLoad() {
        
        addExerciseButton.tintColor = appDelegate.maxTintColor
        setUpExerciseLibraryTableViewController()
        
    }
    
    func setUpExerciseLibraryTableViewController(){
        
        exerciseLibraryTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("libraryTableViewController") as? ExerciseLibraryTableViewController
        
        self.addChildViewController(exerciseLibraryTableViewController!)
        
        self.view.addSubview(exerciseLibraryTableViewController!.view)
        
        exerciseLibraryTableViewController?.view.frame = CGRectMake(0, 44,UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height-44)
        
    }
    
    
    @IBAction func addExerciseToLibrary(sender: UIButton) {
        
        var createExerciseForLibraryViewController = self.storyboard?.instantiateViewControllerWithIdentifier("createExerciseForLibVC") as? CreateExerciseForLibraryViewController!
        
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var beView = UIVisualEffectView(effect: blurEffect)
        beView.frame = UIScreen.mainScreen().bounds
        
        createExerciseForLibraryViewController!.view.frame = UIScreen.mainScreen().bounds
        createExerciseForLibraryViewController!.view.backgroundColor = UIColor.clearColor()
        createExerciseForLibraryViewController!.view.insertSubview(beView, atIndex: 0)
        createExerciseForLibraryViewController!.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        
        self.presentViewController(createExerciseForLibraryViewController!, animated: true, completion: nil)
        
        
    }

}
