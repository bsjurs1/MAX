//
//  ExerciseProfileViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 23.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class ExerciseProfileViewController: UIViewController {
    
    @IBOutlet weak var exerciseProfileView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileAgeLabel: UILabel!

    override func viewDidLoad() {
        
        setUpExerciseTableView()
        
    }
    
    func setUpExerciseTableView(){
        
        var exerciseProfileTableViewController: ExerciseLibraryTableViewController? = self.storyboard?.instantiateViewControllerWithIdentifier("profileTableViewController") as? ExerciseLibraryTableViewController
        
        self.addChildViewController(exerciseProfileTableViewController!)
        
        exerciseProfileTableViewController?.view.frame = CGRectMake(0, 120, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height-120)
        
        self.view.addSubview(exerciseProfileTableViewController!.view)
        
    }

}