//
//  PerformedRepetitionSet.swift
//  MAX
//
//  Created by Bjarte Sjursen on 18.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import Foundation
import CoreData

class PerformedRepetitionSet: PerformedSet {

    @NSManaged var performedRepetitions: NSNumber
    @NSManaged var performedWeightInKg: NSNumber
    @NSManaged var didSet: RepetitionSet

}
