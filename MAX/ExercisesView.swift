//
//  ExercisesView.swift
//  MAX
//
//  Created by Bjarte Sjursen on 07.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class ExercisesView: UIView {
    
    var exercises : Array<ExerciseScrollViewCell> = [ExerciseScrollViewCell]()
    
    var exercisesViewFrame : CGRect
    
    init(){
        
        var numberOfExercises = 10
        
        // Calculating the width of the view frame based on the number of sets
        let widthOfView : CGFloat = UIScreen.mainScreen().bounds.size.width
        var heightOfCollapsedExerciseCells = CGFloat((numberOfExercises-1)*50)
        let heightOfEnlargedExerciseCell = CGFloat(300)
        var spaceBetweenExerciseCells = CGFloat((numberOfExercises+1) * 85)
        var heightOfView = heightOfEnlargedExerciseCell + heightOfEnlargedExerciseCell + spaceBetweenExerciseCells
        exercisesViewFrame = CGRectMake(0.0, 0.0, widthOfView, heightOfView)
        
        super.init(frame: exercisesViewFrame)

        for var i = 1; i<10; ++i {
            var tmp = ExerciseScrollViewCell(center: CGPointMake((UIScreen.mainScreen().bounds.width/2)-0.5, CGFloat(150*i)), inputexerciseNameLabel: "Squats")
            self.addSubview(tmp)
        }
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        exercisesViewFrame = CGRect()
        
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
