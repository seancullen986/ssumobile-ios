//
//  SSULibraryModule.swift
//  SSUMobile
//
//  Created by student on 5/7/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import Foundation

class SSULibraryModule: SSUCoreDataModuleBase, SSUModuleUI {
    
    @objc(sharedInstance)
    static let instance = SSULibraryModule()
    
    let articleFetchDateLimit: TimeInterval = 60*60*24*180; // 6 months
    
    // MARK: SSUModule
    
    var title: String {
        return NSLocalizedString("Library",
                                 comment: "Book a room in the Shulz Library")
    }
    
    var identifier: String {
        return "library"
    }
    
    func setup() {
        //setupCoreData(modelName: "Library", storeName: "Libary")
    }

    /*
    func updateData(_ completion: (() -> Void)? = nil) {
        SSULogging.logDebug("Update Library");
        updateSections {
            self.updateResources {
                completion?()
            }
        }
    }

    func updateSections(completion: (() -> Void)? = nil) {
        SSULogging.logDebug("Update Resource Sections");
        let lastUpdate = SSUConfiguration.sharedInstance().date(forKey: SSUResourcesSectionsUpdatedDateKey)
        SSUMoonlightCommunicator.getJSONFromPath("ssumobile/resources/section", since: lastUpdate) { (response, json, error) in
            if let error = error {
                SSULogging.logError("Error while updating Resources: \(error)")
                completion?()
            } else {
                SSUConfiguration.sharedInstance().setDate(Date(), forKey: SSUResourcesSectionsUpdatedDateKey)
                self.buildSections(json: json)
                completion?()
            }
        }
        
        SSULogging.logDebug("Finish \(title)")
    }
    
    func updateResources(completion: (() -> Void)? = nil) {
        SSULogging.logDebug("Update Resource resources");
        let lastUpdate = SSUConfiguration.sharedInstance().date(forKey: SSUResourcesResourcesUpdatedDateKey)
        SSUMoonlightCommunicator.getJSONFromPath("ssumobile/resources/resource", since: lastUpdate) { (response, json, error) in
            if let error = error {
                SSULogging.logError("Error while updating Resources: \(error)")
                completion?()
            } else {
                SSUConfiguration.sharedInstance().setDate(Date(), forKey: SSUResourcesResourcesUpdatedDateKey)
                self.buildResources(json: json)
                completion?()
            }
        }
    }
    
    private func buildResources(json: Any) {
        guard let jsonData = json as? [Any] else {
            SSULogging.logError("Incorrect data type returned from resources")
            return
        }
        let builder = SSUResourcesBuilder()
        builder.context = backgroundContext
        backgroundContext.perform {
            builder.buildResources(jsonData)
        }
    }
    
    private func buildSections(json: Any) {
        guard let jsonData = json as? [Any] else {
            SSULogging.logError("Incorrect data type returned from resources sections")
            return
        }
        let builder = SSUResourcesBuilder()
        builder.context = backgroundContext
        backgroundContext.perform {
            builder.buildSections(jsonData)
        }
    }
    */
    
    // MARK: SSUModuleUI
    
    func imageForHomeScreen() -> UIImage? {
        return UIImage(named: "library_icon")
        
    }
    
    func viewForHomeScreen() -> UIView? {
        return nil
    }
    
    func initialViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Library_iPhone", bundle: Bundle(for: type(of: self)))
        return storyboard.instantiateInitialViewController()!
    }
    
    func shouldNavigateToModule() -> Bool {
        return true
    }
    
    func showModuleInNavigationBar() -> Bool {
        return false
    }
}
