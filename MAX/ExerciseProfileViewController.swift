//
//  ExerciseProfileViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 23.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class ExerciseProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileAgeLabel: UILabel!

    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        setUpExerciseTableView()
        
        addBlurToView(self.view)
        
    }
    
    func addBlurToView(viewToBlur : UIView){
        
        
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var beView = UIVisualEffectView(effect: blurEffect)
        beView.frame = UIScreen.mainScreen().bounds
        
        self.view.frame = viewToBlur.bounds
        viewToBlur.backgroundColor = UIColor.clearColor()
        
        viewToBlur.insertSubview(beView, atIndex: 0)
        
        
    }
    
    func setUpExerciseTableView(){
        
        var exerciseProfileTableViewController: ExerciseProfileTableViewController? = self.storyboard?.instantiateViewControllerWithIdentifier("profileTableViewController") as? ExerciseProfileTableViewController
        
        self.addChildViewController(exerciseProfileTableViewController!)
        
        exerciseProfileTableViewController?.view.frame = CGRectMake(0, 88, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height-120)
        
        self.view.addSubview(exerciseProfileTableViewController!.view)
        
    }

}
