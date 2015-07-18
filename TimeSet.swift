//
//  TimeSet.swift
//  MAX
//
//  Created by Bjarte Sjursen on 18.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import Foundation
import CoreData

class TimeSet: NSManagedObject {

    @NSManaged var secondsToPerform: NSNumber
    @NSManaged var setNr: NSNumber
    @NSManaged var belongsToExercise: TimeExercise
    @NSManaged var sets: NSSet

}