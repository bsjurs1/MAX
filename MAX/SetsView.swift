//
//  SetsView.swift
//  MAX
//
//  Created by Bjarte Sjursen on 05.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class SetsView: UIView {
    
    var arrayOfSets : Array<ExerciseSetCellView> = [ExerciseSetCellView]()
    
    init(){
        
        var numberOfSets = 4
        
        
        // Calculating the width of the view frame based on the number of sets
        let heightOfSetsView : CGFloat = 250
        var widthOfCollapsedSetCircles = CGFloat((numberOfSets-1)*70)
        let widthOfEnlargedCircle = CGFloat(150)
        var spaceBetweenSetCircles = CGFloat((numberOfSets+1) * 25)
        var widthOfView = widthOfCollapsedSetCircles + widthOfEnlargedCircle + spaceBetweenSetCircles
        let setsViewFrame = CGRectMake(0.0, 0.0, widthOfView, heightOfSetsView)
        
        
        
        super.init(frame: setsViewFrame)
        
        
        // Initialize all the exerciseSetCellViews and add them to self as subviews
        for var i = 1; i <= numberOfSets; ++i {
            
            var set = ExerciseSetCellView(center: CGPointMake(CGFloat(85*i), CGFloat(125)) , setNumber: "Set \(i)")
            
            arrayOfSets.append(set)
            
        }
        for elem in arrayOfSets {
            
            for set in arrayOfSets {
            
                if(set != elem){
                    elem.registerChangeListener(set)
                }
            
            }
            
            self.addSubview(elem)
            
        }
        
        
        // Animate the first setView to show its information
        arrayOfSets[0].changeState()
        
    }

    required init(coder aDecoder: NSCoder) {
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
