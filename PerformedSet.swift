//
//  PerformedSet.swift
//  MAX
//
//  Created by Bjarte Sjursen on 20.07.15.
//  Copyright (c) 2015 Bjarte Sjursen. All rights reserved.
//

import Foundation
import CoreData

class PerformedSet: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var postBreakLength: NSNumber

}
