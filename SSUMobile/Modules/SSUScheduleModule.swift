//
//  SSUScheduleModule.swift
//  SSUMobile
//
//  Created by Eli Simmonds on 4/19/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import Foundation

class SSUScheduleModule: SSUCoreDataModuleBase, SSUModuleUI, SSUSpotlightSupportedProtocol {
    
    @objc(sharedInstance)
    static let instance = SSUScheduleModule()
    
    // MARK: SSUModule
    
    var title: String {
        return NSLocalizedString("Schedule", comment: "Add info about scheduler here") // TODO
    }
    
    var identifier: String {
        return "schedule"
    }
    
    func setup() {
        setupCoreData(modelName: "Schedule", storeName: "Schedule")
    }
    
    func updateData(_ completion: (() -> Void)? = nil) {
        SSULogging.logDebug("Update Schedule")
//        updateSchedule {
//            self.updateClasses {
//                completion?()
//            }
//        }
    }
    
    
    func updateClasses(completion: (() -> Void)? = nil) {
        let date = SSUConfiguration.sharedInstance().date(forKey:SSUScheduleClassesUpdatedDateKey)
        SSUMoonlightCommunicator.getJSONFromPath("schedule/classes", since:date) { (response, json, error) in
            if let error = error {
                SSULogging.logError("Error while attemping to update Schedule Classes: \(error)")
                completion?()
            } else {
                SSUConfiguration.sharedInstance().setDate(Date(), forKey: SSUDirectoryPersonUpdatedDateKey)
                self.buildPeople(json) {
                    completion?()
                }
            }
        }
    }




}







