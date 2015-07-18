//
//  Exercise.swift
//  MAX
//
//  Created by Bjarte Sjursen on 18.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import Foundation
import CoreData

class Exercise: NSManagedObject {

    @NSManaged var exerciseDescription: String
    @NSManaged var exerciseImage: NSData
    @NSManaged var name: String
    @NSManaged var exerciseRoutine: NSSet
    @NSManaged var exerciseVideo: ExerciseVideo
    @NSManaged var performedExerciseData: NSSet

}
