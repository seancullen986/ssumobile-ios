//
//  SSUStudyRoomViewController.swift
//  lib
//
//  Created by student on 5/4/17.
//  Copyright © 2017 student. All rights reserved.
//

import UIKit

class SSUStudyRoomViewController: UIViewController {
    
    let SSULibraryGroupStudyRoomURL = String("https://sonoma.libcal.com/booking/studyrooms")
    let SSULibraryStudentPresentationRoomURL = String("https://sonoma.libcal.com/booking/presentationroom")
    let SSULibraryMediaViewingRoomURL = String("https://sonoma.libcal.com/booking/mediarooms")

    @IBOutlet weak var studyRoomWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load correct website based on Title
        if (self.title == "Group Study Room"){
            if let toLoad = URL(string: SSULibraryGroupStudyRoomURL!){
                let toRequest = URLRequest(url: toLoad)
                studyRoomWebView.loadRequest(toRequest)
            }
            
        }
        else if (self.title == "Media Viewing Room"){
            let toLoad = URL(string: SSULibraryMediaViewingRoomURL!)
            let toRequest = URLRequest(url: toLoad!)
            studyRoomWebView.loadRequest(toRequest)
        }
        else {
            let toLoad = URL(string: SSULibraryStudentPresentationRoomURL!)
            let toRequest = URLRequest(url: toLoad!)
            studyRoomWebView.loadRequest(toRequest)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
