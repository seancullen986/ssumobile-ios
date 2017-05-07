//
//  SSUEventTests.swift
//  SSUMobile
//
//  Created by Eric Amorde on 4/16/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import XCTest
import Nimble
import SwiftyJSON
@testable import SSUMobile

class SSUEventTests: XCTestCase {
    
    var event: SSUEvent!
    
    override func setUp() {
        super.setUp()
        event = SSUEvent(entity: SSUEvent.entity(), insertInto: nil)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testJSONParsing() {
        let dict: [String:Any?] = [
            "id": 411,
            "created": "2017-01-24T08:03:47Z",
            "modified": "2017-04-16T07:03:45Z",
            "deleted": nil,
            "event_id": "588312001b631b4396632d32",
            "title": "ODP: Mt. Shasta Mountaineering",
            "location": "Darwin 103",
            "organization": "CS Department",
            "image_url": "https://static1.squarespace.com/static/53c01f58e4b011307db8af93/55c37a64e4b0d9038d7eb43f/588312001b631b4396632d32/1484985667098/Mount_Shasta_8-4-2007.jpg",
            "url": "http://www.seawolfliving.com/trips/2017/1/21/odp-mt-shasta-mountaineering",
            "start_date": "2017-05-22T15:00:00Z",
            "end_date": "2017-05-25T04:00:00Z",
            "description": "<br>Adventure of a lifetime! Summit Mt. Shasta with ODP after finals this spring. The trip will be led by a certified mountain guide and rentals are included.<br>Dates: 5/22-5/24 | Registration Deadline: 5/5<br>Level: Advanced<br>Cost: $255.00<br>To sign up or get more information, visit the Campus Recreation Front Desk.",
            "category": "Trips"
        ]
        
        let event = self.event!
        
        event.initializeWith(json: JSON(dict))
        
        expect(event.id) == 411
        expect(event.title) == "ODP: Mt. Shasta Mountaineering"
        expect(event.location) == "Darwin 103"
        expect(event.organization) == "CS Department"
        expect(event.imgURL) == "https://static1.squarespace.com/static/53c01f58e4b011307db8af93/55c37a64e4b0d9038d7eb43f/588312001b631b4396632d32/1484985667098/Mount_Shasta_8-4-2007.jpg"
        expect(event.startDate?.iso8601String) == "2017-05-22T15:00:00Z"
        expect(event.endDate?.iso8601String) == "2017-05-25T04:00:00Z"
        expect(event.summary) == "<br>Adventure of a lifetime! Summit Mt. Shasta with ODP after finals this spring. The trip will be led by a certified mountain guide and rentals are included.<br>Dates: 5/22-5/24 | Registration Deadline: 5/5<br>Level: Advanced<br>Cost: $255.00<br>To sign up or get more information, visit the Campus Recreation Front Desk."
        expect(event.category) == "Trips"
    }
}
