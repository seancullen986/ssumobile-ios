//
//  SSUScheduleBuilder.swift
//  SSUMobile
//
//  Created by Chad Vink on 4/19/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import Foundation
import SwiftyJSON

class SSUScheduleBuilder: SSUMoonlightBuilder {
    
    private struct Keys {
        static let term = "Term"
        static let classNbr = "Class Nbr"
        static let department = "Department"
        static let subject = "Subject"
        static let catalog = "Catalog"
        static let section = "Section"
        static let description = "Description"
        static let component = "Component"
        static let minUnits = "Min Units"
        static let maxUnits = "Max Units"
        static let classType = "Class Type"
        static let designation = "Designation"
        static let startTime = "Start Time"
        static let endTime = "End Time"
        static let standartMettingPattern = "Standard Meeting Pattern"
        static let instructorID = "Instructor ID"
        static let firstName = "First Name"
        static let lastName = "Last Name"
        static let combinedSection = "Combined Section"
        static let autoEnrol = "Auto Enrol"
        static let autoEnrol2 = "Auto Enr 2"
        static let acadGroup = "Acad Group"
        static let descr = "Descr"
        static let facilityID = "Facility ID"
        static let csNumber = "CS Number"
        static let wtu = "WTU"
        static let kFactor = "K Factor"
        static let sFactor = "S Factor"
        static let workoadFactor = "Workoad Factor"
    }
    
//    static func event(withID id: Int, inContext: NSManagedObjectContext) -> SSUCourse? {
//        if id <= 0 {
//            SSULogging.logError("Received invalid event id \(id)")
//            return nil
//        }
//        
//        let obj = self.object(withEntityName: "SSUCourse", id: id, context: inContext) as? SSUCourse
//        // Here we don't know if this is a new object or one that already existed, so make sure it has an id
//        
//        obj?.id = Int32(id)
//        
//        return obj
//    }
    
    override func build(_ results: Any!) {
        SSULogging.logDebug("Building events")
        let json = JSON(results)
        
        for entry in json.arrayValue {
            let mode = self.mode(fromJSONData: entry.dictionaryObject ?? [:])
            guard let event = SSUCalendarBuilder.event(withID: entry[Keys.id].intValue, inContext: self.context) else {
                SSULogging.logError("Unable to retrieve or create Event with id: \(entry[Keys.id].intValue)")
                return
            }
            if mode == .deleted {
                context.delete(event)
                continue
            }
            
            event.startDate = dateFormatter.date(from: entry[Keys.startDate].stringValue)
            event.endDate = dateFormatter.date(from: entry[Keys.endDate].stringValue)
            event.title = entry[Keys.title].string
            event.organization = entry[Keys.organization].string
            event.category = entry[Keys.category].string
            event.location = entry[Keys.location].string
            event.summary = entry[Keys.summary].string
        }
        saveContext()
        SSULogging.logDebug("Finish building events")
    }


}

