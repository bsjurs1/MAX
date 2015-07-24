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
    
    
    func addDoneButtonOnKeyboard()
    {
        var doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.BlackTranslucent
        
        var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        var done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneButtonAction"))
        done.tintColor = appDelegate.maxTintColor
        
        var items = NSMutableArray()
        items.addObject(flexSpace)
        items.addObject(done)
        
        doneToolbar.items = items as [AnyObject]
        doneToolbar.sizeToFit()
        
        self.repetitionsTextField.inputAccessoryView = doneToolbar
        self.repetitionsTextField.inputAccessoryView = doneToolbar
        
        self.weightTextField.inputAccessoryView = doneToolbar
        self.weightTextField.inputAccessoryView = doneToolbar
        
    }
    
    func doneButtonAction()
    {
        self.repetitionsTextField.resignFirstResponder()
        self.weightTextField.resignFirstResponder()
    }

}
