//
//  SetsView.swift
//  MAX
//
//  Created by Bjarte Sjursen on 05.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class SetsView: UIView {
    
    let heightOfSetsView : CGFloat = 250
    
    var widthOfView : CGFloat
    
    init(){
        
        var numberOfSets = 4
        
        widthOfView = CGFloat((numberOfSets-1)*70) + CGFloat(150) + CGFloat((numberOfSets+1) * 25)
        
        var sizeOfSetsView = CGRectMake(0.0, 0.0, widthOfView, heightOfSetsView)
        
        super.init(frame: sizeOfSetsView)
        
        var arrayOfSets : Array<ExerciseSetCellView> = [ExerciseSetCellView]()
        
        for var i = 1; i <= numberOfSets; ++i {
            
            var set = ExerciseSetCellView(center: CGPointMake(CGFloat(85*i), CGFloat(125)) , setNumber: "Set \(i)")
            
            arrayOfSets.append(set)
            
        }
        
        for elem in arrayOfSets {
            
            self.addSubview(elem)
            
        }
        
    }

    required init(coder aDecoder: NSCoder) {
        
        widthOfView = CGFloat()
        
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
