//
//  ExerciseRoutinesCollectionViewController.swift
//  MAX
//
//  Created by Bjarte Sjursen on 25.06.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit
import CoreData

class ExerciseRoutinesCollectionViewController: CoreDataCollectionViewController {
    
    @IBOutlet weak var editExerciseRoutineBarButton: UIBarButtonItem!
    @IBOutlet weak var addExerciseRoutineBarButton: UIBarButtonItem!
    
    var animator : UIDynamicAnimator?
    var gravity : UIGravityBehavior?
    var collider : UICollisionBehavior?
    var snapBehavior : UISnapBehavior?
    var managedContext : NSManagedObjectContext?
    
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var profileViewController : ExerciseProfileViewController?
    
    override func viewDidLoad() {
        
        managedContext = appDelegate.managedObjectContext!
        
        let exercisesFetchRequest = NSFetchRequest(entityName: "ExerciseRoutine")
        let primarySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        exercisesFetchRequest.sortDescriptors = [primarySortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: exercisesFetchRequest, managedObjectContext: self.managedContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        var error: NSError? = nil
        if (fetchedResultsController!.performFetch(&error) == false) {
            print("An error occurred: \(error?.localizedDescription)")
        }

        
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
            
            if(profileViewController!.view.frame.origin.y <= UIScreen.mainScreen().bounds.size.height-300){
                
                snapBehavior = UISnapBehavior(item: profileViewController!.view, snapToPoint: CGPointMake(UIScreen.mainScreen().bounds.size.width/2, 400))
                
                animator!.addBehavior(snapBehavior)
                
                animator?.addBehavior(collider)
                
                collider?.addBoundaryWithIdentifier("leftBoundary", forPath: UIBezierPath(rect: CGRectMake(-1, 0, 1, UIScreen.mainScreen().bounds.size.height)))
                
                collider?.addBoundaryWithIdentifier("rightBoundary", forPath: UIBezierPath(rect: CGRectMake(UIScreen.mainScreen().bounds.size.width+1, 0, 1, UIScreen.mainScreen().bounds.size.height)))
                
            }
            else {
                animator?.addBehavior(gravity)
                animator?.addBehavior(collider)
                collider?.addBoundaryWithIdentifier("bottomFallBoundary", forPath: UIBezierPath(rect: CGRectMake(0, (UIScreen.mainScreen().bounds.size.height*2)-59, UIScreen.mainScreen().bounds.size.width, 1)))
                collider?.addBoundaryWithIdentifier("leftBoundary", forPath: UIBezierPath(rect: CGRectMake(-1, 0, 1, UIScreen.mainScreen().bounds.size.height)))
                
                collider?.addBoundaryWithIdentifier("rightBoundary", forPath: UIBezierPath(rect: CGRectMake(UIScreen.mainScreen().bounds.size.width+1, 0, 1, UIScreen.mainScreen().bounds.size.height)))
            }
        }
        
        var translation : CGPoint = gestureRecognizer.translationInView(self.view)
        
        gestureRecognizer.view?.center = CGPointMake((UIScreen.mainScreen().bounds.width/2), profileViewController!.view.center.y + translation.y)
        
        gestureRecognizer.setTranslation(CGPointMake(0,0), inView: self.view)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        collectionView?.reloadData()
        
    }
 
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var newIndexPath : NSIndexPath
        var exerciseRoutine : ExerciseRoutine?
        
        if(indexPath.row != 0){
            newIndexPath = NSIndexPath(forItem: (indexPath.item-1), inSection: indexPath.section)
            exerciseRoutine = fetchedResultsController!.objectAtIndexPath(newIndexPath) as? ExerciseRoutine
        }

        if indexPath.row == 0 && indexPath.section == 0{
            
            var cell : UICollectionViewCell
            
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("addButtonCell", forIndexPath: indexPath) as! UICollectionViewCell
            
            return cell
            
        }
        else if indexPath.section == 0 && indexPath.row % numerOfCellsOnScreenWidth() == 0 {
            
            var cell : ExerciseRoutineCollectionViewLeftCell
            
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("leftRoutineCell", forIndexPath: indexPath) as! ExerciseRoutineCollectionViewLeftCell
            
            //cell.exerciseRoutinePrintScreenImageView?.image = UIImage(contentsOfFile: "prtscreen.png")
            
            //println(exerciseRoutine.name)

            if (exerciseRoutine?.name != nil){
                 cell.exerciseRoutineNameLabel.text = exerciseRoutine!.name
            } else {
                
                cell.exerciseRoutineNameLabel.text = "sample"
            }
            
            return cell
            
        }
        else if ((indexPath.section == 0) && (indexPath.row % numerOfCellsOnScreenWidth()) == (numerOfCellsOnScreenWidth()-1)) {
            
            var cell : ExerciseRoutineCollectionViewRightCell
            
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("rightRoutineCell", forIndexPath: indexPath) as! ExerciseRoutineCollectionViewRightCell
            
            //cell.exerciseRoutineImageView?.image = UIImage(contentsOfFile: "prtscreen.png")
            
            if (exerciseRoutine?.name != nil){
                cell.exerciseRoutineNameLabel.text = exerciseRoutine!.name
            } else {
                
                cell.exerciseRoutineNameLabel.text = "sample"
            }
            
            return cell
        
        }
        else{
            
            var cell : ExerciseRoutineCollectionViewMiddleCell
            
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("middleRoutineCell", forIndexPath: indexPath) as! ExerciseRoutineCollectionViewMiddleCell
            
            //cell.exerciseRoutineImageView?.image = UIImage(contentsOfFile: "prtscreen.png")
            
            if (exerciseRoutine?.name != nil){
                cell.exerciseRoutineNameLabel.text = exerciseRoutine!.name
            } else {
                
                cell.exerciseRoutineNameLabel.text = "sample"
            }
            
            return cell
        }
        
    }
    
    func numerOfCellsOnScreenWidth()-> Int {
        
        var numberToFloor = (UIScreen.mainScreen().bounds.size.width)/112.0
        
        var convertedNumberToFloor : Int = Int(numberToFloor)
        
        return convertedNumberToFloor
        
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
