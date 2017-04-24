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

    @NSManaged public var workoadFactor: String?
    @NSManaged public var sFactor: Int16
    @NSManaged public var kFactor: Int16
    @NSManaged public var wtu: Int16
    @NSManaged public var csNumber: Int16
    @NSManaged public var facilityID: String?
    @NSManaged public var descr: String?
    @NSManaged public var acadGroup: Int16
    @NSManaged public var autoEnr2: String?
    @NSManaged public var autoEnrol: String?
    @NSManaged public var combinedSection: String?
    @NSManaged public var lastName: String?
    @NSManaged public var firstName: String?
    @NSManaged public var instructorID: Int64
    @NSManaged public var standardMettingPattern: String?
    @NSManaged public var endTime: String?
    @NSManaged public var startTime: String?
    @NSManaged public var designation: String?
    @NSManaged public var classType: String?
    @NSManaged public var maxUnits: Int16
    @NSManaged public var minUnits: Int16
    @NSManaged public var component: String?
    @NSManaged public var description1: String?
    @NSManaged public var section: Int16
    @NSManaged public var catalog: String?
    @NSManaged public var subject: String?
    @NSManaged public var department: String?
    @NSManaged public var classNbr: Int16
    @NSManaged public var term: Int16

}
