//
//  SSUCourse+CoreDataProperties.swift
//  SSUMobile
//
//  Created by Jonathon Thompson on 5/6/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import Foundation
import CoreData


extension SSUCourse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SSUCourse> {
        return NSFetchRequest<SSUCourse>(entityName: "SSUCourse")
    }

    @NSManaged public var acad_group: String?
    @NSManaged public var auto_enroll1: String?
    @NSManaged public var auto_enroll2: String?
    @NSManaged public var catalog: String?
    @NSManaged public var class_number: Int16
    @NSManaged public var class_type: String?
    @NSManaged public var combined_section: String?
    @NSManaged public var component: String?
    @NSManaged public var cs_number: String?
    @NSManaged public var department: String?
    @NSManaged public var descript: String?
    @NSManaged public var designation: String?
    @NSManaged public var end_time: String?
    @NSManaged public var facility_id: String?
    @NSManaged public var first_name: String?
    @NSManaged public var id: Int64
    @NSManaged public var instructor_id: String?
    @NSManaged public var k_factor: String?
    @NSManaged public var last_name: String?
    @NSManaged public var max_units: String?
    @NSManaged public var meeting_pattern: String?
    @NSManaged public var min_units: String?
    @NSManaged public var s_factor: String?
    @NSManaged public var school_name: String?
    @NSManaged public var section: String?
    @NSManaged public var start_time: String?
    @NSManaged public var subject: String?
    @NSManaged public var term: String?
    @NSManaged public var workload_factor: String?
    @NSManaged public var wtu: String?

}
