//
//  SSUCourse+CoreDataProperties.swift
//  SSUMobile
//
//  Created by Chad Vink on 4/19/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import Foundation
import CoreData


extension SSUCourse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SSUCourse> {
        return NSFetchRequest<SSUCourse>(entityName: "SSUCourse")
    }

    @NSManaged public var id: Int64
    @NSManaged public var workoad_factor: String?
    @NSManaged public var s_factor: Int16
    @NSManaged public var k_kactor: Int16
    @NSManaged public var wtu: Int16
    @NSManaged public var cs_number: Int16
    @NSManaged public var facility_id: String?
    @NSManaged public var descript: String?
    @NSManaged public var acad_group: Int16
    @NSManaged public var auto_enroll2: Int16
    @NSManaged public var auto_enroll1: Int16
    @NSManaged public var combined_section: String?
    @NSManaged public var last_name: String?
    @NSManaged public var first_name: String?
    @NSManaged public var instructor_id: Int32
    @NSManaged public var metting_pattern: String?
    @NSManaged public var end_time: String?
    @NSManaged public var start_time: String?
    @NSManaged public var designation: String?
    @NSManaged public var class_type: String?
    @NSManaged public var max_units: Int16
    @NSManaged public var min_units: Int16
    @NSManaged public var component: String?
    @NSManaged public var school_name: String?
    @NSManaged public var section: Int16
    @NSManaged public var catalog: String?
    @NSManaged public var subject: String?
    @NSManaged public var department: String?
    @NSManaged public var class_number: Int16
    @NSManaged public var term: Int16

}
