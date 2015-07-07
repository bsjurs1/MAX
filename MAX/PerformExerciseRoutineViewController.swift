//
//  PerformExerciseRoutineViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 02.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class PerformExerciseRoutineViewController: UIViewController {
    
    var setStateListeners : Array<ExerciseScrollViewCell> = [ExerciseScrollViewCell]()

    @IBOutlet weak var exercisesScrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for var i = 1; i<10; ++i {
            
            var tmp = ExerciseScrollViewCell(center: CGPointMake((UIScreen.mainScreen().bounds.width/2)-0.5, CGFloat(100*i)), inputexerciseNameLabel: "Squats")
            
            self.view.addSubview(tmp)
            
        }
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
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
