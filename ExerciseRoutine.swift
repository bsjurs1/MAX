//
//  ExerciseRoutine.swift
//  MAX
//
//  Created by Bjarte Sjursen on 20.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import Foundation
import CoreData

class ExerciseRoutine: NSManagedObject {

    @NSManaged var backGroundImage: NSData
    @NSManaged var name: String
    @NSManaged var performedExerciseRoutineData: NSSet
    @NSManaged var exercises: NSSet

}
