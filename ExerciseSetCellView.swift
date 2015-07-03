//
//  ExerciseSetCellView.swift
//  MAX
//
//  Created by Bjarte Sjursen on 03.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class ExerciseSetCellView: UIView {
    
    var baseLayer : CALayer
    var baseLayerCollapsedSize = CGSizeMake(70, 70)
    
    init(center : CGPoint, inputExerciseNameLabel : String){
        
        baseLayer = CALayer()
        baseLayer.borderColor = UIColor.grayColor().CGColor
        baseLayer.backgroundColor = UIColor.clearColor().CGColor
        baseLayer.borderWidth = 0.5
        baseLayer.frame.size = baseLayerCollapsedSize
        baseLayer.frame.origin = CGPointMake(0, 0)
        baseLayer.cornerRadius = 35
        
        super.init(frame: CGRectMake(0, 0, baseLayerCollapsedSize.width, baseLayerCollapsedSize.height))
        
        self.center = center
        self.layer.addSublayer(baseLayer)
        
    
    }
    
    required init(coder aDecoder: NSCoder) {
        
        self.baseLayer = CALayer()
        
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
