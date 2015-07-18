//
//  PerformedTimeSet.swift
//  MAX
//
//  Created by Bjarte Sjursen on 18.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import Foundation
import CoreData

class PerformedTimeSet: PerformedSet {

    @NSManaged var performedTimeInSeconds: NSNumber
    @NSManaged var didSet: TimeSet

}
