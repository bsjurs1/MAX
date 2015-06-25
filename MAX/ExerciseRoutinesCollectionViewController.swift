//
//  ExerciseRoutinesCollectionViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 25.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class ExerciseRoutinesCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("exerciseRoutineCell", forIndexPath: indexPath) as! ExerciseRoutineCollectionViewCell
        
        cell.exerciseRoutinePrintScreenImageView = UIImageView(image: UIImage(contentsOfFile: "prtscreen.png"))
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 200
        
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    

}
