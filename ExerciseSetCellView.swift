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
    var reptitionsLabel : UILabel
    var weightLabel : UILabel
    
    
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
        
        
        reptitionsLabel = UILabel()
        weightLabel = UILabel()
        
        super.init(frame: baseLayerCollapsedSize)
        
        self.center = center
        self.layer.addSublayer(baseLayer)
        self.addSubview(setNumberLabel)
        
        var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "changeState:")
        self.addGestureRecognizer(tapGestureRecognizer)
        
    
    }
    
    func changeState(tapGestureRecognizer : UITapGestureRecognizer){
        
        self.frame.size = baseLayerEnlargedSize.size
        
        var sizeAnimation = CABasicAnimation(keyPath: "bounds")
        sizeAnimation.fromValue = NSValue(CGRect: self.baseLayerCollapsedSize)
        sizeAnimation.toValue = NSValue(CGRect: self.baseLayerEnlargedSize)
        sizeAnimation.duration = 0.3
        self.baseLayer.bounds = self.baseLayerEnlargedSize
        self.baseLayer.addAnimation(sizeAnimation, forKey: "bounds")
        
        var sizeAnimation = CABasicAnimation(keyPath: "bounds")
        sizeAnimation.fromValue = NSValue(CGRect: self.baseLayerCollapsedSize)
        sizeAnimation.toValue = NSValue(CGRect: self.baseLayerEnlargedSize)
        sizeAnimation.duration = 0.3
        self.baseLayer.bounds = self.baseLayerEnlargedSize
        self.baseLayer.addAnimation(sizeAnimation, forKey: "bounds")
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        self.baseLayer = CALayer()
        
        setNumberLabel = UILabel()
        
        reptitionsLabel = UILabel()
        
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
