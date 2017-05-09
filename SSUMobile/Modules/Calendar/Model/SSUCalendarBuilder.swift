//
//  SSUCalendarBuilder.swift
//  SSUMobile
//
//  Created by Eric Amorde on 4/1/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import Foundation
import SwiftyJSON

class SSUCalendarBuilder: SSUMoonlightBuilder {

    private struct Keys {
        static let id = "id"
    }
    
    static func event(withID id: Int, inContext: NSManagedObjectContext) -> SSUEvent? {
        if id <= 0 {
            SSULogging.logError("Received invalid event id \(id)")
            return nil
        }
        
        let obj = self.object(withEntityName: "SSUEvent", id: id, context: inContext) as? SSUEvent
        // Here we don't know if this is a new object or one that already existed, so make sure it has an id
        obj?.id = Int32(id)
        
        return obj
    }
    
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
            
            event.initializeWith(json: entry)
        }
        saveContext()
        SSULogging.logDebug("Finish building events")
    }
}
