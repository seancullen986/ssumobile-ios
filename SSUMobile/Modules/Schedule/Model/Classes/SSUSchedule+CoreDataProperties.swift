//
//  SSUSchedule+CoreDataProperties.swift
//  SSUMobile
//
//  Created by Jonathon Thompson on 5/6/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import Foundation
import CoreData


extension SSUSchedule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SSUSchedule> {
        return NSFetchRequest<SSUSchedule>(entityName: "SSUSchedule")
    }

    @NSManaged public var class_number: Int16
    @NSManaged public var end_time: String?
    @NSManaged public var id: Int64
    @NSManaged public var start_time: String?
    @NSManaged public var term: Int16

}
