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
        
        exerciseNameLabel = UILabel()
        exerciseNameLabel.center = CGPointMake(UIScreen.mainScreen().bounds.width/2, 25)
        exerciseNameLabel.bounds.size = CGSizeMake(300, 50)
        exerciseNameLabel.textAlignment = NSTextAlignment.Center
        exerciseNameLabel.text = inputexerciseNameLabel
        
        
        baseLayer = CALayer()
        baseLayer.borderColor = UIColor.grayColor().CGColor
        baseLayer.backgroundColor = UIColor.whiteColor().CGColor
        baseLayer.borderWidth = 0.5
        baseLayer.frame = baseLayerCollapsedSize
        
        
        super.init(frame: baseLayerCollapsedSize)
        
        self.addSubview(exerciseNameLabel)
        self.layer.addSublayer(baseLayer)
        self.bringSubviewToFront(exerciseNameLabel)
        
    }
    
    func changeState(tapGestureRecognizer : UITapGestureRecognizer){
        
        if(collapsedState){
            
            collapsedState = false
            
            baseLayer.borderColor = UIColor.orangeColor().CGColor
            baseLayer.borderWidth = 1
            
            var animation = CABasicAnimation(keyPath: "bounds")
            animation.fromValue = NSValue(CGRect: baseLayerCollapsedSize)
            animation.toValue = NSValue(CGRect: baseLayerEnlargedSize)
            animation.duration = 0.3
            baseLayer.bounds = baseLayerEnlargedSize
            baseLayer.addAnimation(animation, forKey: "bounds")
            
            UIView.animateWithDuration(0.3, animations: {

                self.frame.size = self.baseLayerEnlargedSize.size
                self.exerciseNameLabel.textAlignment = NSTextAlignment.Left
                
            })
            
            
        }
        else{
            
            collapsedState = true
            
            baseLayer.borderColor = UIColor.grayColor().CGColor
            baseLayer.borderWidth = 0.5
            
            var animation = CABasicAnimation(keyPath: "bounds")
            animation.fromValue = NSValue(CGRect: baseLayerEnlargedSize)
            animation.toValue = NSValue(CGRect: baseLayerCollapsedSize)
            animation.duration = 0.3
            baseLayer.bounds = baseLayerCollapsedSize
            baseLayer.addAnimation(animation, forKey: "bounds")
            
            UIView.animateWithDuration(0.3, animations: {
                
                self.frame.size = self.baseLayerCollapsedSize.size
                self.exerciseNameLabel.textAlignment = NSTextAlignment.Center
                
            })

            
            
            
            
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
