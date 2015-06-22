//
//  ExerciseTableViewCell.swift
//  MAX
//
//  Created by Bjarte Sjursen on 21.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var exerciseImageView : UIImageView?
    
    @IBOutlet weak var exerciseNameLabel : UILabel?
    
    @IBOutlet weak var lastPerformanceDateLabel : UILabel?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
        
    }
    
    
    /*- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
    // Helpers
    CGSize size = self.contentView.frame.size;
    
    // Initialize Main Label
    self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0, 8.0, size.width - 16.0, size.height - 16.0)];
    
    // Configure Main Label
    [self.mainLabel setFont:[UIFont boldSystemFontOfSize:24.0]];
    [self.mainLabel setTextAlignment:NSTextAlignmentCenter];
    [self.mainLabel setTextColor:[UIColor orangeColor]];
    [self.mainLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    
    // Add Main Label to Content View
    [self.contentView addSubview:self.mainLabel];
    }
    
    return self;
    }*/
    
    

}
