//
//  PerformExerciseRoutineViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 02.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class PerformExerciseRoutineViewController: UIViewController {

    @IBOutlet weak var exercisesScrollView: UIScrollView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var exerciseView = ExerciseRoutineTrainingView()
        
        exercisesScrollView.contentSize = CGSizeMake(exerciseView.exerciseRoutineTrainingViewFrame.width, exerciseView.exerciseRoutineTrainingViewFrame.height)
        
        exercisesScrollView.addSubview(exerciseView)
        
        exerciseView.exercises[0].changeState()
        
        
        
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
