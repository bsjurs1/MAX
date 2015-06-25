//
//  ExerciseEditTableViewCell.swift
//  MAX
//
//  Created by Bjarte Sjursen on 24.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class ExerciseEditTableViewCell: UITableViewCell {
    
    var appDelegate = AppDelegate()
    var usedByViewController = ExerciseRoutineTableViewController()
    
    @IBOutlet weak var exerciseDetailsButton: UIButton!
    @IBOutlet weak var addSetButton: UIButton!
    @IBOutlet weak var editExerciseButton: UIButton!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseImageView: UIImageView!

    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
