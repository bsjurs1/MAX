//
//  SetsView.swift
//  MAX
//
//  Created by Bjarte Sjursen on 05.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class SetsView: UIView {
    
    var sets : Array<SetView> = [SetView]()
    
    var setsViewFrame : CGRect
    
    init(){
        
        var numberOfSets = 10
        
        // Calculating the width of the view frame based on the number of sets
        let heightOfSetsView : CGFloat = 250
        var widthOfCollapsedSetCircles = CGFloat((numberOfSets-1)*70)
        let widthOfEnlargedCircle = CGFloat(150)
        var spaceBetweenSetCircles = CGFloat((numberOfSets+1) * 12)
        var widthOfView = widthOfCollapsedSetCircles + widthOfEnlargedCircle + spaceBetweenSetCircles
        setsViewFrame = CGRectMake(0.0, 0.0, widthOfView, heightOfSetsView)
        
        super.init(frame: setsViewFrame)
        
        // Initialize all the SetViews and add them to self as subviews
        for var i = 1; i <= numberOfSets; ++i {
            
            var set = SetView(center: CGPointMake(CGFloat(85*i), CGFloat(125)) , setNumber: "Set \(i)")
            
            sets.append(set)
            
        }
        for elem in sets {
            
            for set in sets {
                if(set != elem){
                    elem.registerChangeListener(set)
                }
            
            }
            
            self.addSubview(elem)
            
        }
        
        self.backgroundColor = UIColor.clearColor()
        
        var lineView = UIView(frame: CGRectMake(70, 125, self.setsViewFrame.width-125, 1))
        lineView.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(lineView)
        self.sendSubviewToBack(lineView)
        
        
        // Animate the first setView to show its information
        sets[0].changeState()
        sets[0].updateListenersState()
        sets[0].updateListenerPosition()
        sets[0].tappedBefore = true
    
    }

    required init(coder aDecoder: NSCoder) {
        
        setsViewFrame = CGRect()
        
        super.init(coder: aDecoder)
    }
    
    

    
    /*// Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
    }
    */
}
