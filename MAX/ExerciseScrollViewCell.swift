//
//  ExerciseScrollViewCell.swift
//  MAX
//
//  Created by Bjarte Sjursen on 02.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit
import CoreGraphics

class ExerciseScrollViewCell: UIView {
    
    let baseLayerCollapsedSize = CGRectMake(0, 0, 300, 50)
    let baseLayerEnlargedSize = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 400)
    var exerciseNameLabel : UILabel
    var baseLayer : CALayer
    var collapsedState : Bool = true
    

    convenience init(center : CGPoint, inputexerciseNameLabel : String){
        
        self.init(inputexerciseNameLabel: inputexerciseNameLabel)
        
        var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "changeState:")
        
        self.addGestureRecognizer(tapGestureRecognizer)
        
        self.center = center
        
    }
    
    init(inputexerciseNameLabel : String){
        
        exerciseNameLabel = UILabel(frame: baseLayerCollapsedSize)
        exerciseNameLabel.textAlignment = NSTextAlignment.Center
        exerciseNameLabel.text = inputexerciseNameLabel
        
        
        baseLayer = CALayer()
        baseLayer.borderColor = UIColor.grayColor().CGColor
        baseLayer.borderWidth = 0.5
        baseLayer.frame = baseLayerCollapsedSize
        
        
        super.init(frame: baseLayerCollapsedSize)
        
        self.addSubview(exerciseNameLabel)
        
        self.layer.addSublayer(baseLayer)
        
    }
    
    func changeState(tapGestureRecognizer : UITapGestureRecognizer){
        
        println("tapped the square")
        
        if(collapsedState){
            
            collapsedState = false
            
            self.frame = baseLayerEnlargedSize
            
            var animation = CABasicAnimation(keyPath: "frame")
            animation.fromValue = layer.valueForKey("frame")
            animation.toValue = NSValue(CGRect: baseLayerEnlargedSize)
            animation.duration = 10
            baseLayer.frame = baseLayerEnlargedSize
            baseLayer.addAnimation(animation, forKey: "frame")
            
            UIView.animateWithDuration(10, animations: {
            
                
                
                
            })
            
            
        }
        else{
            
            
            
            
        }
        
    }

    required init(coder aDecoder: NSCoder) {
        
        self.exerciseNameLabel = UILabel()
        
        self.baseLayer = CALayer()
        
        super.init(coder: aDecoder)
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {

        
    }
    */

}
