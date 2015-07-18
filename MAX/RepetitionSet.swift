//
//  RepetitionSet.swift
//  MAX
//
//  Created by Bjarte Sjursen on 18.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import Foundation
import CoreData

class RepetitionSet: NSManagedObject {

    @NSManaged var numberOfRepetitions: NSNumber
    @NSManaged var setNr: NSNumber
    @NSManaged var weightToLift: NSNumber
    @NSManaged var belongsToExercise: RepetitionExercise
    @NSManaged var sets: NSSet

}
