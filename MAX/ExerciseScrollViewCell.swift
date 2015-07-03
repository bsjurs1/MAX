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
    
    var appDelegate = AppDelegate()
    
    let baseLayerCollapsedSize = CGRectMake(0, 0, 300, 50)
    let exerciseNameLabelSize = CGRectMake(100, 0, 100, 50)
    let baseLayerEnlargedSize = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 300)
    var exerciseNameLabel : UILabel
    var baseLayer : CALayer
    var collapsedState : Bool = true
    var informationButton : UIButton

    convenience init(center : CGPoint, inputexerciseNameLabel : String){
        
        self.init(inputexerciseNameLabel: inputexerciseNameLabel)
        
        var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "changeState:")
        
        self.addGestureRecognizer(tapGestureRecognizer)
        self.center = center
        
    }
    
    init(inputexerciseNameLabel : String){
        
        exerciseNameLabel = UILabel(frame: exerciseNameLabelSize)
        exerciseNameLabel.text = inputexerciseNameLabel
        exerciseNameLabel.textAlignment = NSTextAlignment.Center
        
        
        baseLayer = CALayer()
        baseLayer.borderColor = UIColor.grayColor().CGColor
        baseLayer.backgroundColor = UIColor.whiteColor().CGColor
        baseLayer.borderWidth = 0.5
        baseLayer.frame = baseLayerCollapsedSize

        self.informationButton = UIButton.buttonWithType(UIButtonType.InfoLight) as! UIButton
        self.informationButton.frame = CGRectMake(UIScreen.mainScreen().bounds.width-100, 0, 50, 50)
        self.informationButton.tintColor = appDelegate.maxTintColor
        self.informationButton.hidden = true
        
        super.init(frame: baseLayerCollapsedSize)
        
        self.addSubview(exerciseNameLabel)
        self.layer.addSublayer(baseLayer)
        self.bringSubviewToFront(exerciseNameLabel)
        self.addSubview(informationButton)
        self.bringSubviewToFront(informationButton)
        
    }
    
    func changeState(tapGestureRecognizer : UITapGestureRecognizer){
        
        if(collapsedState){
            
            maximizeBaseLayerBoundsWithAnimation(0.2)
            
            collapsedState = false
            
            baseLayer.borderColor = UIColor.orangeColor().CGColor
            baseLayer.borderWidth = 1
            
            UIView.animateWithDuration(0.2, animations: {
                
                self.center.y += 115
                self.frame.size = self.baseLayerEnlargedSize.size
                self.exerciseNameLabel.center.y -= 115
                self.informationButton.hidden = false
                self.informationButton.frame.origin.y -= 115
                
            })
            
        } else{
            
            minimizeBaseLayerBoundsWithAnimation(0.2)
            
            collapsedState = true
            
            baseLayer.borderColor = UIColor.grayColor().CGColor
            baseLayer.borderWidth = 0.5
            
            UIView.animateWithDuration(0.25, animations: {
                
                self.exerciseNameLabel.frame.origin.y = self.baseLayerCollapsedSize.origin.y
                self.frame.size = self.baseLayerCollapsedSize.size
                self.center.y -= 115
                self.informationButton.hidden = true
                self.informationButton.frame.origin.y += 115
                
            })
        }
        
    }
    
    func minimizeBaseLayerBoundsWithAnimation(duration : Double){
        
        var animation = CABasicAnimation(keyPath: "bounds")
        animation.fromValue = NSValue(CGRect: baseLayerEnlargedSize)
        animation.toValue = NSValue(CGRect: baseLayerCollapsedSize)
        animation.duration = duration
        baseLayer.bounds = baseLayerCollapsedSize
        baseLayer.addAnimation(animation, forKey: "bounds")
        
    }
    
    func maximizeBaseLayerBoundsWithAnimation(duration : Double){
        
        var animation = CABasicAnimation(keyPath: "bounds")
        animation.fromValue = NSValue(CGRect: self.baseLayerCollapsedSize)
        animation.toValue = NSValue(CGRect: self.baseLayerEnlargedSize)
        animation.duration = duration
        self.baseLayer.bounds = self.baseLayerEnlargedSize
        self.baseLayer.addAnimation(animation, forKey: "bounds")
        
    }

    required init(coder aDecoder: NSCoder) {
        
        self.exerciseNameLabel = UILabel()
        
        self.baseLayer = CALayer()
        
        self.informationButton = UIButton()
        
        super.init(coder: aDecoder)
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {

        
    }
    */

}
