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
    
    static func event(withID id: Int, inContext: NSManagedObjectContext) -> SSUCourse? {
        if id <= 0 {
            SSULogging.logError("Received invalid event id \(id)")
            return nil
        }
        
        let obj = self.object(withEntityName: "SSUCourse", id: id, context: inContext) as? SSUCourse
        // Here we don't know if this is a new object or one that already existed, so make sure it has an id
        
        obj?.classNbr = Int16(id)
        
        return obj
    }
    
    override func build(_ results: Any!) {
        SSULogging.logDebug("Building events")
        var json : JSON?
        
        if let path = Bundle.main.path(forResource: "sample", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    print("jsonData:\(jsonObj)")
                    json = jsonObj
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }

        
        for entry in (json?.arrayValue)! {
            let mode = self.mode(fromJSONData: entry.dictionaryObject ?? [:])
            guard let event = SSUScheduleBuilder.event(withID: entry[Keys.classNbr].intValue, inContext: self.context) else {
                SSULogging.logError("Unable to retrieve or create Event with id: \(entry[Keys.classNbr].intValue)")
                return
            }
            if mode == .deleted {
                context.delete(event)
                continue
            }
            event.classNbr = Int16(entry[Keys.classNbr].intValue)
            SSULogging.log(String(event.classNbr))
        }
        saveContext()
        SSULogging.logDebug("Finish building events")
    }


}

