//
//  ExerciseRoutineTrainingView.swift
//  MAX
//
//  Created by Bjarte Sjursen on 07.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class ExerciseRoutineTrainingView: UIView {
    
    var exercises : Array<ExerciseTrainingView> = [ExerciseTrainingView]()
    
    var exerciseRoutineTrainingViewFrame : CGRect
    
    var lineView : UIView
    
    init(){
        
        var numberOfExercises = 10
        
        // Calculating the width of the view frame based on the number of sets
        let widthOfView : CGFloat = UIScreen.mainScreen().bounds.size.width
        var heightOfCollapsedExerciseCells = CGFloat((numberOfExercises-1)*50)
        let heightOfEnlargedExerciseCell = CGFloat(300)
        var spaceBetweenExerciseCells = CGFloat((numberOfExercises+1) * 85)
        var heightOfView = heightOfEnlargedExerciseCell + heightOfEnlargedExerciseCell + spaceBetweenExerciseCells
        exerciseRoutineTrainingViewFrame = CGRectMake(0.0, 0.0, widthOfView, heightOfView)
        
        lineView = UIView(frame: CGRectMake(self.exerciseRoutineTrainingViewFrame.size.width/2, -500, 0.5, self.exerciseRoutineTrainingViewFrame.height+500))
        
        lineView.backgroundColor = UIColor.lightGrayColor()
        
        super.init(frame: exerciseRoutineTrainingViewFrame)

        for var i = 1; i<10; ++i {
            var tmp = ExerciseTrainingView(center: CGPointMake((UIScreen.mainScreen().bounds.width/2)-0.5, CGFloat(150*i)), inputexerciseNameLabel: "Squats", superView: self)
            self.addSubview(tmp)
            exercises.append(tmp)
        }
        
        for exercise in exercises {
            for listenerToAdd in exercises{
                exercise.registerChangeListener(listenerToAdd)
            }
        }

        self.exercises[0].updateListenersState()
        self.exercises[0].updateListenerPosition()
        self.exercises[0].tappedBefore = true
        
        self.addSubview(lineView)
        self.sendSubviewToBack(lineView)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        lineView = UIView()
        
        exerciseRoutineTrainingViewFrame = CGRect()
        
        super.init(coder: aDecoder)
        
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
