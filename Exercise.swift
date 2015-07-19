//
//  Exercise.swift
//  MAX
//
//  Created by Bjarte Sjursen on 19.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class Exercise: NSManagedObject {

    @NSManaged var exerciseDescription: String
    @NSManaged var exerciseImage: NSData
    @NSManaged var name: String
    @NSManaged var sectionId: String
    @NSManaged var exerciseRoutine: NSSet
    @NSManaged var exerciseVideo: ExerciseVideo
    @NSManaged var performedExerciseData: NSSet
    
    
    func insertImage(imagePath : String){
        
        self.exerciseImage = NSData(contentsOfFile: "/exerciseImage/" + imagePath)!
        
    }
    func getImage()-> UIImage {
        
        return UIImage(data: self.exerciseImage)!
        
    }

}
