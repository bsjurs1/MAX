//
//  RoutineExercise.swift
//  MAX
//
//  Created by Bjarte Sjursen on 20.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import Foundation
import CoreData

class RoutineExercise: NSManagedObject {

    @NSManaged var exerciseNr: NSNumber
    @NSManaged var belongsToRoutine: ExerciseRoutine
    @NSManaged var isKindOfExercise: Exercise

}
