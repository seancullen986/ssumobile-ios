//
//  SSUTimeTracker+CoreDataProperties.swift
//  SSUMobile
//
//  Created by Jonathon Thompson on 5/10/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import Foundation
import CoreData


extension SSUTimeTracker {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SSUTimeTracker> {
        return NSFetchRequest<SSUTimeTracker>(entityName: "SSUTimeTracker")
    }
    

    @NSManaged public var last_run: NSDate?

}
