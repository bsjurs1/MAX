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
    var baseLayerCollapsedSize = CGRectMake(0, 0, 70, 70)
    var baseLayerEnlargedSize = CGRectMake(0, 0, 150, 150)
    var setNumberLabel : UILabel
    var repetitionsLabel : UILabel
    var weightLabel : UILabel
    var collapsedState : Bool = true
    
    
    init(center : CGPoint, setNumber : String){
        
        baseLayer = CALayer()
        baseLayer.borderColor = UIColor.grayColor().CGColor
        baseLayer.backgroundColor = UIColor.clearColor().CGColor
        baseLayer.borderWidth = 0.5
        baseLayer.frame = baseLayerCollapsedSize
        baseLayer.cornerRadius = 35
        
        setNumberLabel = UILabel(frame: baseLayerCollapsedSize)
        setNumberLabel.text = setNumber
        setNumberLabel.textAlignment = NSTextAlignment.Center
        setNumberLabel.textColor = UIColor.lightGrayColor()
        
        
        repetitionsLabel = UILabel(frame: baseLayerCollapsedSize)
        repetitionsLabel.frame.size.width += 50
        repetitionsLabel.frame.origin.x -= 25
        repetitionsLabel.text = "10 repetitions"
        repetitionsLabel.textColor = UIColor.whiteColor()
        repetitionsLabel.textAlignment = NSTextAlignment.Center
        repetitionsLabel.hidden = true
        
        weightLabel = UILabel()
        
        super.init(frame: baseLayerCollapsedSize)
        
        self.center = center
        self.layer.addSublayer(baseLayer)
        self.addSubview(setNumberLabel)
        self.addSubview(repetitionsLabel)
        
        var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "changeState:")
        self.addGestureRecognizer(tapGestureRecognizer)
        
    
    }
    
    func changeState(tapGestureRecognizer : UITapGestureRecognizer){
        
        if(collapsedState){
            
            collapsedState = false
            
            UIView.animateWithDuration(0.2, animations: {
                
                self.frame.size = self.baseLayerEnlargedSize.size
                self.setNumberLabel.textColor = UIColor.whiteColor()
                self.setNumberLabel.frame.origin.y -= 50
                self.repetitionsLabel.hidden = false
                
            })
            
            var sizeAnimation = CABasicAnimation(keyPath: "bounds")
            sizeAnimation.fromValue = NSValue(CGRect: self.baseLayerCollapsedSize)
            sizeAnimation.toValue = NSValue(CGRect: self.baseLayerEnlargedSize)
            sizeAnimation.duration = 0.2
            self.baseLayer.bounds = self.baseLayerEnlargedSize
            self.baseLayer.addAnimation(sizeAnimation, forKey: "bounds")
            
            var cornerAnimation = CABasicAnimation(keyPath: "cornerRadius")
            cornerAnimation.fromValue = NSNumber(double: 35)
            cornerAnimation.toValue = NSNumber(double: 75)
            cornerAnimation.duration = 0.2
            self.baseLayer.cornerRadius = 75
            self.baseLayer.addAnimation(cornerAnimation, forKey: "cornerRadius")
            
            var fillAnimation = CABasicAnimation(keyPath: "backgroundColor")
            fillAnimation.fromValue = UIColor.clearColor().CGColor
            fillAnimation.toValue = UIColor.orangeColor().CGColor
            fillAnimation.duration = 0.2
            self.baseLayer.backgroundColor = UIColor.orangeColor().CGColor
            self.baseLayer.addAnimation(cornerAnimation, forKey: "backgroundColor")
            
            var borderAnimation = CABasicAnimation(keyPath: "borderColor")
            borderAnimation.fromValue = UIColor.lightGrayColor().CGColor
            borderAnimation.toValue = UIColor.orangeColor().CGColor
            borderAnimation.duration = 0.2
            self.baseLayer.borderColor = UIColor.orangeColor().CGColor
            self.baseLayer.addAnimation(borderAnimation, forKey: "borderColor")
            
            
        } else{
            
            collapsedState = true
            
            var sizeAnimation = CABasicAnimation(keyPath: "bounds")
            sizeAnimation.fromValue = NSValue(CGRect: self.baseLayerEnlargedSize)
            sizeAnimation.toValue = NSValue(CGRect: self.baseLayerCollapsedSize)
            sizeAnimation.duration = 0.2
            self.baseLayer.bounds = self.baseLayerCollapsedSize
            self.baseLayer.addAnimation(sizeAnimation, forKey: "bounds")
            
            var cornerAnimation = CABasicAnimation(keyPath: "cornerRadius")
            cornerAnimation.fromValue = NSNumber(double: 75)
            cornerAnimation.toValue = NSNumber(double: 35)
            cornerAnimation.duration = 0.2
            self.baseLayer.cornerRadius = 35
            self.baseLayer.addAnimation(cornerAnimation, forKey: "cornerRadius")
            
            var fillAnimation = CABasicAnimation(keyPath: "backgroundColor")
            fillAnimation.fromValue = UIColor.orangeColor().CGColor
            fillAnimation.toValue = UIColor.clearColor().CGColor
            fillAnimation.duration = 0.2
            self.baseLayer.backgroundColor = UIColor.clearColor().CGColor
            self.baseLayer.addAnimation(cornerAnimation, forKey: "backgroundColor")
            
            var borderAnimation = CABasicAnimation(keyPath: "borderColor")
            borderAnimation.fromValue = UIColor.orangeColor().CGColor
            borderAnimation.toValue = UIColor.lightGrayColor().CGColor
            borderAnimation.duration = 0.2
            self.baseLayer.borderColor = UIColor.lightGrayColor().CGColor
            self.baseLayer.addAnimation(borderAnimation, forKey: "borderColor")
            
            UIView.animateWithDuration(0.2, animations: {
            
                self.frame.size = self.baseLayerCollapsedSize.size
                self.setNumberLabel.textColor = UIColor.lightGrayColor()
                self.setNumberLabel.frame.origin.y += 50
                self.repetitionsLabel.hidden = true
                
            })
            
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        
        self.baseLayer = CALayer()
        
        setNumberLabel = UILabel()
        
        repetitionsLabel = UILabel()
        
        weightLabel = UILabel()
        
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
