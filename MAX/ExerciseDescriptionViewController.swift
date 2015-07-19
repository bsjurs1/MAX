//
//  ExerciseDescriptionViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 19.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class ExerciseDescriptionViewController: UIViewController {
    
    @IBOutlet weak var doneButton: UIButton!
    var appDelegate = AppDelegate()
    @IBOutlet weak var exerciseDescriptionTextView: UITextView!
    var exerciseDescription = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseDescriptionTextView.backgroundColor = UIColor.clearColor()
        exerciseDescriptionTextView.textColor = UIColor.whiteColor()
        
        self.view.backgroundColor = UIColor.clearColor()
        self.doneButton.tintColor = appDelegate.maxTintColor
        
        self.exerciseDescriptionTextView.text = exerciseDescription

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneViewing(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
