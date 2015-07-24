//
//  EditExerciseSetTableViewCell.swift
//  MAX
//
//  Created by Bjarte Sjursen on 24.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class EditExerciseSetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repetitionsTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var setNumberLabel: UILabel!
    var appDelegate = AppDelegate()
    var set : RepetitionSet?
    
    
    func addDoneButtonToNumpads(){
        
        addDoneButtonOnRepetitionKeyboard()
        addDoneButtonOnWeightKeyboard()
        
    }
    
    func addDoneButtonOnRepetitionKeyboard()
    {
        var doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.BlackTranslucent
        
        var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        var done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneRepetitionKeyboardButtonAction"))
        done.tintColor = appDelegate.maxTintColor
        
        var items = NSMutableArray()
        items.addObject(flexSpace)
        items.addObject(done)
        
        doneToolbar.items = items as [AnyObject]
        doneToolbar.sizeToFit()
        
        self.repetitionsTextField.inputAccessoryView = doneToolbar

    }
    
    func doneRepetitionKeyboardButtonAction()
    {
        if (set != nil){
            
            set!.numberOfRepetitions = NSNumber(int: (repetitionsTextField.text as NSString).intValue)
            
        }
        
        self.repetitionsTextField.resignFirstResponder()
    }
    
    func addDoneButtonOnWeightKeyboard(){
        
        var doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.BlackTranslucent
        
        var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        var done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneWeightKeyboardButtonAction"))
        done.tintColor = appDelegate.maxTintColor
        
        var items = NSMutableArray()
        items.addObject(flexSpace)
        items.addObject(done)
        
        doneToolbar.items = items as [AnyObject]
        doneToolbar.sizeToFit()
        
        self.weightTextField.inputAccessoryView = doneToolbar

    }
    
    func doneWeightKeyboardButtonAction(){
        
        if (set != nil){
            
            set!.weightToLift = NSNumber(double: (weightTextField.text as NSString).doubleValue)
            
        }
        
        self.weightTextField.resignFirstResponder()
    }

}
