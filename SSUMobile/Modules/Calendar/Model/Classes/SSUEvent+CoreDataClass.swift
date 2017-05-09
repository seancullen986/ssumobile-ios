//
//  SSUEvent+CoreDataClass.swift
//  SSUMobile
//
//  Created by Eric Amorde on 3/31/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

@objc(SSUEvent)
public class SSUEvent: NSManagedObject, SSUJSONInitializable {
    
    private struct Keys {
        static let id = "id"
        static let startDate = "start_date"
        static let endDate = "end_date"
        static let title = "title"
        static let organization = "organization"
        static let category = "category"
        static let location = "location"
        static let summary = "description"
        static let imgURL = "image_url"
    }
    
    func initializeWith(dict: [AnyHashable : Any]) {
        initializeWith(json: JSON(dict))
    }
    
    func initializeWith(json: JSON) {
        id = json[Keys.id].int32Value
        startDate = SSUDateUtils.dateFrom(iso8601String: json[Keys.startDate].stringValue)
        endDate = SSUDateUtils.dateFrom(iso8601String: json[Keys.endDate].stringValue)
        imgURL = json[Keys.imgURL].string
        title = json[Keys.title].string
        organization = json[Keys.organization].string
        category = json[Keys.category].string
        location = json[Keys.location].string
        summary = json[Keys.summary].string
    }
}
