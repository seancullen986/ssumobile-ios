//
//  SSUScheduleModule.swift
//  SSUMobile
//
//  Created by Eli Simmonds on 4/19/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import Foundation
import SwiftyJSON

final class SSUScheduleModule: SSUCoreDataModuleBase, SSUModuleUI {
    
    @objc(sharedInstance)
    static let instance = SSUScheduleModule()
    
    // MARK: SSUModule
    
    var title: String {
        return NSLocalizedString("Schedule", comment: "A tool for students to view their classes and search current courses offered at SSU")
    }
    
    var identifier: String {
        return "schedule"
    }
    
    func setup() {
        setupCoreData(modelName: "Schedule", storeName: "Schedule")
    }
    
    
    func updateData(_ completion: (() -> Void)? = nil) {
        SSULogging.logDebug("Update Catalog")
        self.updateCatalog {
            completion?()
        }
    }
    
    func updateCatalog(completion: (() -> Void)? = nil) {
            SSUMoonlightCommunicator.getJSONFromPath("catalog/course") { (response, json, error) in
            if let error = error {
                SSULogging.logError("Error while attemping to update Schedule Classes: \(error)")
                completion?()
            } else {
                self.compile(json: json) {
                    completion?()
                }
            }
        }
    }
    
    private func fetchNext(url: URL, completion: @escaping (_ result: Any?) -> ()) {
        
        SSUCommunicator.getJSONFrom(url) { (response, json, error) in
            if let error = error {
                SSULogging.logError("Error while attemping to update Schedule Classes: \(error)")
                completion(nil)
            } else {
                completion(json)
            }
        }

    }
    
    static var jData: Any?
        
    
    
    
    private func compile(json: Any, completion: (() -> Void)? = nil) {
        let builder = SSUCourseBuilder()
        builder.context = backgroundContext
        backgroundContext.perform {

            var next = builder.fetchComplete(json)
            if( next != "") {
                repeat {
                    if let url = URL(string: next) {
                        self.fetchNext(url: url, completion: { (result) in
                            if let more = result {
                                next = builder.fetchComplete(more)
                            } else { next = "" }
                        })
                    }

                } while(next != "")
            } else {
                self.build(json: builder.getResults() as Any) {
                    completion?()
                }
            }
        }
        
    }

    
    private func build(json: Any, completion: (() -> Void)? = nil) {
        let builder = SSUCourseBuilder()
        builder.context = backgroundContext
        backgroundContext.perform {
            var next = ""
            repeat {
                next = builder.fetchComplete(json)
            } while(next != "");
            
            builder.build(json)
            SSULogging.logDebug("Finish building Schedule")
            completion?()
        }
    }
    
    
    // MARK: SSUModuleUI
    
    func imageForHomeScreen() -> UIImage? {
        return UIImage(named: "schedule_icon") 
    }
    
    func viewForHomeScreen() -> UIView? {
        return nil
    }
    
    func initialViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Schedule", bundle: Bundle(for: type(of: self)))
        return storyboard.instantiateInitialViewController()!     }
    
    func shouldNavigateToModule() -> Bool {
        return true
    }
    
    func showModuleInNavigationBar() -> Bool {
        return false
    }
    
}



