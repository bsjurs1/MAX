//
//  PerformedExerciseRoutineData.swift
//  MAX
//
//  Created by Bjarte Sjursen on 18.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import Foundation
import CoreData

class PerformedExerciseRoutineData: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var didExerciseRoutine: ExerciseRoutine

}
