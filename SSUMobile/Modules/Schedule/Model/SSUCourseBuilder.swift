//
//  SSUScheduleBuilder.swift
//  SSUMobile
//
//  Created by Chad Vink on 4/19/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import Foundation
import SwiftyJSON

class SSUCourseBuilder: SSUMoonlightBuilder {
    
    private struct Keys {
        static let id = "id"
        static let term = "term"
        static let class_number = "class_number"
        static let department = "department"
        static let subject = "subject"
        static let catalog = "catalog"
        static let section = "section"
        static let descript = "description"
        static let component = "component"
        static let min_units = "min_units"
        static let max_units = "max_units"
        static let class_type = "class_type"
        static let designation = "designation"
        static let start_time = "start_time"
        static let end_time = "end_time"
        static let metting_pattern = "meeting_pattern"
        static let instructor_id = "instructor_id"
        static let first_name = "first_name"
        static let last_name = "last_name"
        static let combined_section = "combined_section"
        static let auto_enroll1 = "auto_enroll1"
        static let auto_enroll2 = "auto_enroll2"
        static let acad_group = "acad_group"
        static let school_name = "class_name"
        static let facility_id = "facility_id"
        static let cs_number = "cs_number"
        static let wtu = "wtu"
        static let k_factor = "k_factor"
        static let s_factor = "s_factor"
        static let workoad_factor = "workoad_factor"
    }
    
    var jsonResults: JSON?
    var js: Any?
    var arrOJ: [[JSON]] = []
    //var arrOJ: [Dictionary<String, Any>] = []
    //var arrOJ: JSON?
    
    static func course(withID id: Int, inContext: NSManagedObjectContext) -> SSUCourse? {
        if id <= 0 {
            SSULogging.logError("Received invalid course id \(id)")
            return nil
        }
        
        SSULogging.log("ScheduleBuilder:course -- courseID  \(id) is valid")
        
        let obj = self.object(withEntityName: "SSUCourse", id: id, context: inContext) as? SSUCourse
        // Here we don't know if this is a new object or one that already existed, so make sure it has an id
        obj?.id = Int64(id)
        
        return obj
    }
    
    func fetchComplete(_ results: Any) -> (String, Any?) {
        let data = JSON(results)
        if let next = data.dictionaryValue["next"]?.string {
            if( next == "null" ) { return ("", nil)}
            if let arr = data.dictionaryValue["results"]?.arrayValue {
                //arrOJ.append(arr)
                
                return (next, arr)
            }
            
        }
        
        return ("", nil)
    }
    
    func getResults() -> Any? {
        return arrOJ
    }
    
    override func build(_ results: Any!) {
        SSULogging.logDebug("Building events")
        let arr = JSON(results).arrayValue
        
        for page in arr {
            let data = JSON(page).array!
            for entry in (JSON(data).arrayValue) {
                let mode = self.mode(fromJSONData: entry.dictionaryObject ?? [:])
                
                SSULogging.log("Event id = \(entry[Keys.id])")

                guard let course = SSUCourseBuilder.course(withID: entry[Keys.id].intValue, inContext: self.context) else {
                    SSULogging.logError("Unable to retrieve or create Event with id: \(entry[Keys.id].intValue)")
                    return
                }
                if mode == .deleted {
                    context.delete(course)
                    continue
                }
                course.term = entry[Keys.term].int16 ?? 0
                course.class_number = entry[Keys.class_number].int16 ?? 0
                course.department = entry[Keys.department].string
                course.subject = entry[Keys.subject].string
                course.catalog = entry[Keys.catalog].string
                course.section = entry[Keys.section].int16 ?? 0
                course.descript = entry[Keys.designation].string
                course.component = entry[Keys.component].string
                course.max_units = entry[Keys.max_units].int16 ?? 0
                course.min_units = entry[Keys.min_units].int16 ?? 0
                course.class_type = entry[Keys.class_type].string
                course.designation = entry[Keys.designation].string
    //            course.metting_pattern = entry[Keys.metting_pattern].string
                course.instructor_id = entry[Keys.instructor_id].int32 ?? 0
                course.first_name =  entry[Keys.first_name].string
                course.last_name = entry[Keys.last_name].string
                course.combined_section = entry[Keys.combined_section].string
                course.auto_enroll1 = entry[Keys.auto_enroll1].int16 ?? 0
                course.auto_enroll2 = entry[Keys.auto_enroll2].int16 ?? 0
                course.acad_group = entry[Keys.acad_group].int16 ?? 0
                course.school_name = entry[Keys.school_name].string
                course.facility_id = entry[Keys.facility_id].string
                course.cs_number = entry[Keys.cs_number].int16 ?? 0
                course.wtu = entry[Keys.wtu].int16 ?? 0
    //            course.k_kactor = entry[Keys.k_factor].int16 ?? 0
                course.s_factor = entry[Keys.s_factor].int16 ?? 0
    //            course.workoad_factor = entry[Keys.workoad_factor].string
                if let d = course.descript {
                    print("\(d)")
                }
                
                SSULogging.log(String(course.id))
            }
        }
        saveContext()
        SSULogging.logDebug("Finish building catalog")
    }


}

