//
//  SSUScheduleModule.swift
//  SSUMobile
//
//  Created by Eli Simmonds on 4/19/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import Foundation


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
                self.compile(json: json, next: "") {
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
    
    static var jData: [Any] = []
    
    
    
    
    private func compile(json: Any, next: String, completion: (() -> Void)? = nil) {
        let builder = SSUCourseBuilder()
        builder.context = backgroundContext
        backgroundContext.perform {
            var address = next
            var data: Any?
            if (address == "") {
                (address, data) = builder.fetchComplete(json)
            }
            
            if let x = data {
                SSUScheduleModule.jData.append(x)
            }
            
            if( address != "") {

                if let url = URL(string: address) {
                    self.fetchNext(url: url, completion: { (result) in
                        if let more = result {
                            (address, data) = builder.fetchComplete(more)
                            
                            if let x = data {
                                SSUScheduleModule.jData.append(x)
                            }
                            
                            self.compile(json: result as Any, next: address) {
                                completion?()
                            }
                        } else { address = "" }
                    })
                }


            } else {
                self.build(json: SSUScheduleModule.jData as Any ) {
                    completion?()
                }
            }
        }
        
    }

    
    private func build(json: Any, completion: (() -> Void)? = nil) {
        let builder = SSUCourseBuilder()
        builder.context = backgroundContext
        backgroundContext.perform {
            
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



