//
//  ExerciseTrainingView.swift
//  MAX
//
//  Created by Bjarte Sjursen on 02.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit
import CoreGraphics

class ExerciseTrainingView: UIView {
    
    var appDelegate = AppDelegate()
    let baseLayerCollapsedSize = CGRectMake(0, 0, 300, 50)
    let exerciseNameLabelSize = CGRectMake(100, 0, 100, 50)
    let baseLayerEnlargedSize = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 300)
    var exerciseNameLabel : UILabel
    var baseLayer : CALayer
    var isCollapsed : Bool = true
    var informationButton : UIButton
    var setsScrollView : UIScrollView?
    var setsView : SetsView?
    var centerOfView = CGPoint()
    var exerciseImageView : UIImageView
    var tappedBefore : Bool = false
    var changeListeners : Array<ExerciseTrainingView> = [ExerciseTrainingView]()
    var superView : ExerciseRoutineTrainingView
    
    
    func registerChangeListener(listener : ExerciseTrainingView){
        if(listener != self){
            changeListeners.append(listener)
        }
    }
    
    func updateListenersState(){
        for listener in changeListeners {
            if(listener.isCollapsed == false){
                listener.changeState()
            }
            listener.tappedBefore = false
        }
        
    }
    
    func updateListenerPosition(){
        
        for listener in changeListeners {
            
            listener.moveToOriginalPosition()
            
            if (listener.center.y > self.center.y){
                listener.moveDown()
            }
            else {
                listener.moveUp()
            }
        }
    }


    convenience init(center : CGPoint, inputexerciseNameLabel : String, superView : ExerciseRoutineTrainingView){
        
        
        self.init(inputexerciseNameLabel: inputexerciseNameLabel, superView : superView)
        
        var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "gotTapped:")
        
        self.addGestureRecognizer(tapGestureRecognizer)
        self.centerOfView = center
        self.backgroundColor = UIColor.whiteColor()
        self.center = center
        
    }
    
    init(inputexerciseNameLabel : String, superView : ExerciseRoutineTrainingView){
        
        exerciseNameLabel = UILabel(frame: baseLayerCollapsedSize)
        exerciseNameLabel.textColor = UIColor.lightGrayColor()
        exerciseNameLabel.text = inputexerciseNameLabel
        exerciseNameLabel.textAlignment = NSTextAlignment.Center
        
        
        baseLayer = CALayer()
        baseLayer.borderColor = UIColor.grayColor().CGColor
        baseLayer.backgroundColor = UIColor.clearColor().CGColor
        baseLayer.borderWidth = 0.5
        baseLayer.frame = baseLayerCollapsedSize
        
        exerciseImageView = UIImageView(frame: CGRectMake(5, 0, 100, 100))
        exerciseImageView.image = UIImage(contentsOfFile: "/Users/Bjarte/Documents/MAX_projectFolder/MAX/squats.png")
        exerciseImageView.hidden = true
        exerciseImageView.contentMode = UIViewContentMode.ScaleAspectFit

        self.informationButton = UIButton.buttonWithType(UIButtonType.InfoLight) as! UIButton
        self.informationButton.frame = CGRectMake(UIScreen.mainScreen().bounds.width-50, 0, 50, 50)
        self.informationButton.tintColor = appDelegate.maxTintColor
        self.informationButton.hidden = true
        
        self.setsView = SetsView()
        
        self.superView = superView
        
        super.init(frame: baseLayerCollapsedSize)
    
        self.addSubview(exerciseNameLabel)
        self.layer.addSublayer(baseLayer)
        self.bringSubviewToFront(exerciseNameLabel)
        self.addSubview(informationButton)
        self.bringSubviewToFront(informationButton)
        self.addSubview(exerciseImageView)
        
    }
    
    func changeState(){
        
        if(isCollapsed){
            
            maximizeBaseLayerBoundsWithAnimation(0.2)
            
            isCollapsed = false
            
            baseLayer.borderColor = UIColor.orangeColor().CGColor
            baseLayer.borderWidth = 1
            
            UIView.animateWithDuration(0.2, animations: {
                
                self.setsScrollView = UIScrollView(frame: CGRectMake(0 , 50, UIScreen.mainScreen().bounds.size.width, 250))
                
                self.setsScrollView!.contentSize = CGSizeMake(self.setsView!.setsViewFrame.size.width, 250)
                
                self.setsScrollView!.addSubview(self.setsView!)
                
                self.bringSubviewToFront(self.setsScrollView!)
                self.setsScrollView!.bringSubviewToFront(self.setsView!)
                
                self.addSubview(self.setsScrollView!)

                self.frame.size = self.baseLayerEnlargedSize.size
                self.center = self.centerOfView
                self.informationButton.hidden = false
                self.exerciseNameLabel.center.x = UIScreen.mainScreen().bounds.width/2
                
                self.exerciseImageView.hidden = false
                
            })
            
        }
        else{
            
            minimizeBaseLayerBoundsWithAnimation(0.2)
            
            isCollapsed = true
            
            baseLayer.borderColor = UIColor.grayColor().CGColor
            baseLayer.borderWidth = 0.5
            
            UIView.animateWithDuration(0.2, animations: {
                
                self.frame.size = self.baseLayerCollapsedSize.size
                self.informationButton.hidden = true
                self.setsScrollView!.hidden = true
                self.center = self.centerOfView
                self.exerciseNameLabel.center.x = self.baseLayerCollapsedSize.width/2
                
                self.exerciseImageView.hidden = true
            })
        }
        
    }
    
    func gotTapped(tapGestureRecognizer : UITapGestureRecognizer){
        
        changeState()
        updateListenersState()
        
        if(tappedBefore == false){
            tappedBefore = true
            updateListenerPosition()
            
        } else{
            tappedBefore = false
            
            for listener in changeListeners {
                
                listener.moveToOriginalPosition()
                
            }
        }

        
    }
    
    func minimizeBaseLayerBoundsWithAnimation(duration : Double){
        
        var animation = CABasicAnimation(keyPath: "frame")
        animation.fromValue = NSValue(CGRect: baseLayerEnlargedSize)
        animation.toValue = NSValue(CGRect: baseLayerCollapsedSize)
        animation.duration = duration
        baseLayer.frame = baseLayerCollapsedSize
        baseLayer.addAnimation(animation, forKey: "frame")
        
    }
    
    func maximizeBaseLayerBoundsWithAnimation(duration : Double){
        
        var animation = CABasicAnimation(keyPath: "frame")
        animation.fromValue = NSValue(CGRect: baseLayerCollapsedSize)
        animation.toValue = NSValue(CGRect: baseLayerEnlargedSize)
        animation.duration = duration
        baseLayer.frame = self.baseLayerEnlargedSize
        baseLayer.addAnimation(animation, forKey: "frame")
        
    }
    
    func moveDown() {
        UIView.animateWithDuration(0.2, animations: {
            self.center.y += 100
            self.superView.lineView.center.y-=300
        })
    }
    
    func moveUp(){
        UIView.animateWithDuration(0.2, animations: {
            self.center.y -= 100
            self.superView.lineView.center.y+=300
        })
    }
    
    func moveToOriginalPosition(){
        UIView.animateWithDuration(0.2, animations: {
            self.center.y = self.centerOfView.y
            self.superView.lineView.center.y = (((self.superView.exerciseRoutineTrainingViewFrame.height/2)-320/2)+150)
        })
    }

    required init(coder aDecoder: NSCoder) {
        
        self.exerciseNameLabel = UILabel()
        
        self.baseLayer = CALayer()
        
        self.informationButton = UIButton()
        
        self.setsScrollView = UIScrollView()
        
        self.setsView = SetsView()
        
        self.exerciseImageView = UIImageView()
        
        self.superView = ExerciseRoutineTrainingView()
        
        super.init(coder: aDecoder)
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {

        
    }
    */

}
