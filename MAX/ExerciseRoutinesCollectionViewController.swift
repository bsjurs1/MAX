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
        
        var cell : ExerciseRoutineCollectionViewCell
        
        if indexPath.row % numerOfCellsOnScreenWidth() == 0{
            
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("leftRoutineCell", forIndexPath: indexPath) as! ExerciseRoutineCollectionViewCell
            
        }
        else if (indexPath.row % numerOfCellsOnScreenWidth()) == (numerOfCellsOnScreenWidth()-1) {
            
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("rightRoutineCell", forIndexPath: indexPath) as! ExerciseRoutineCollectionViewCell
            
        }
        else{
            
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("middleRoutineCell", forIndexPath: indexPath) as! ExerciseRoutineCollectionViewCell
            
        }
        
        cell.exerciseRoutinePrintScreenImageView = UIImageView(image: UIImage(contentsOfFile: "prtscreen.png"))
        
        return cell
    }
    
    func numerOfCellsOnScreenWidth()-> Int {
        
        
        var numberToFloor = (UIScreen.mainScreen().bounds.size.width)/120.0
        
        var convertedNumberToFloor : Int = Int(numberToFloor)
        
        return convertedNumberToFloor
        
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 200
        
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    

}
