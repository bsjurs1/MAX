//
//  ExerciseRoutinesCollectionViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 25.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit

class ExerciseRoutinesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var editExerciseRoutineBarButton: UIBarButtonItem!
    @IBOutlet weak var addExerciseRoutineBarButton: UIBarButtonItem!
    
    var animator : UIDynamicAnimator?
    var gravity : UIGravityBehavior?
    var collider : UICollisionBehavior?
    
    var appDelegate = AppDelegate()
    var profileViewController : ExerciseProfileViewController?
    
    override func viewDidLoad() {
        
        animator = UIDynamicAnimator(referenceView: self.view)
        
        addExerciseRoutineBarButton.tintColor = appDelegate.maxTintColor
        editExerciseRoutineBarButton.tintColor = appDelegate.maxTintColor
        
        addExerciseProfileViewController()
        
        
    }
    
    func addExerciseProfileViewController(){
        
        profileViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("profileViewController") as? ExerciseProfileViewController)!
        
        self.addChildViewController(profileViewController!)
        
        self.view.addSubview(profileViewController!.view)
        
        profileViewController?.view.frame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height-80, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.height)
        
        var gestureRecognizer =  UIPanGestureRecognizer(target: self, action: "moveView:")
        
        gestureRecognizer.maximumNumberOfTouches = 1
        
        profileViewController!.view.addGestureRecognizer(gestureRecognizer)
        
        gravity = UIGravityBehavior(items: [profileViewController!.view])
        
        animator?.addBehavior(gravity!)
        
        collider = UICollisionBehavior(items: [profileViewController!.view])
        
        animator?.addBehavior(collider!)
        
        collider?.addBoundaryWithIdentifier("bottomFallBoundary", forPath: UIBezierPath(rect: CGRectMake(0, (UIScreen.mainScreen().bounds.size.height*2)-59, UIScreen.mainScreen().bounds.size.width, 1)))

        
    }
    
    func moveView(gestureRecognizer : UIPanGestureRecognizer){
        
        if (gestureRecognizer.state == UIGestureRecognizerState.Began){
            animator?.removeAllBehaviors()
        }
        
        else if (gestureRecognizer.state == UIGestureRecognizerState.Ended){
            animator?.addBehavior(gravity)
            animator?.addBehavior(collider)
            collider?.addBoundaryWithIdentifier("bottomFallBoundary", forPath: UIBezierPath(rect: CGRectMake(0, (UIScreen.mainScreen().bounds.size.height*2)-59, UIScreen.mainScreen().bounds.size.width, 1)))
        }
        
        var translation : CGPoint = gestureRecognizer.translationInView(self.view)
        
        gestureRecognizer.view?.center = CGPointMake((UIScreen.mainScreen().bounds.width/2), profileViewController!.view.center.y + translation.y)
        
        gestureRecognizer.setTranslation(CGPointMake(0,0), inView: self.view)
        
    }
 
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell : ExerciseRoutineCollectionViewCell

        if indexPath.row == 0 {
            
            var cell : UICollectionViewCell
            
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("addButtonCell", forIndexPath: indexPath) as! UICollectionViewCell
            
            return cell
            
        }
        else if indexPath.row % numerOfCellsOnScreenWidth() == 0 {
            
            
            
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("leftRoutineCell", forIndexPath: indexPath) as! ExerciseRoutineCollectionViewCell
            
            
            //FIX THE IMAGE LOADING
            //cell.exerciseRoutinePrintScreenImageView?.
            //cell.exerciseRoutinePrintScreenImageView?.image = UIImage(contentsOfFile: "prtscreen.png")
            
        }
        else if (indexPath.row % numerOfCellsOnScreenWidth()) == (numerOfCellsOnScreenWidth()-1) {
            
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("rightRoutineCell", forIndexPath: indexPath) as! ExerciseRoutineCollectionViewCell
            
            cell.exerciseRoutinePrintScreenImageView?.image = UIImage(contentsOfFile: "prtscreen.png")
            
        }
        else{
            
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("middleRoutineCell", forIndexPath: indexPath) as! ExerciseRoutineCollectionViewCell
            
            cell.exerciseRoutinePrintScreenImageView?.image = UIImage(contentsOfFile: "prtscreen.png")
            
        }
        
        return cell
        
    }
    
    func numerOfCellsOnScreenWidth()-> Int {
        
        var numberToFloor = (UIScreen.mainScreen().bounds.size.width)/112.0
        
        var convertedNumberToFloor : Int = Int(numberToFloor)
        
        return convertedNumberToFloor
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
        
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        
        switch kind {
        
        case UICollectionElementKindSectionHeader:
            
            var headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "bjarte", forIndexPath: indexPath) as! ExerciseRoutineCollectionSearchBarHeaderView
            
            headerView.searchBar.searchBarStyle = UISearchBarStyle.Minimal
            
            return headerView
         
        default:
            
            assert(false, "Unexpected element kind")
            
        }
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        
    }
    

}
