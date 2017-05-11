//
//  SSULibraryViewController.swift
//  lib
//
//  Created by student on 5/4/17.
//  Copyright © 2017 student. All rights reserved.
//

import UIKit

class SSULibraryViewController: UIViewController {
    
    @IBOutlet weak var GSButton: UIButton!
    @IBOutlet weak var MVButton: UIButton!
    @IBOutlet weak var SPButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Button Beautification
        MVButton.layer.cornerRadius = 10
        GSButton.layer.cornerRadius = 10
        SPButton.layer.cornerRadius = 10
        MVButton.layer.borderWidth = 3
        GSButton.layer.borderWidth = 3
        SPButton.layer.borderWidth = 3
        MVButton.layer.borderColor = UIColor.white.cgColor
        GSButton.layer.borderColor = UIColor.white.cgColor
        SPButton.layer.borderColor = UIColor.white.cgColor

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // Prepare SSUStudyRoomViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        segue.destination.title = segue.identifier
    }


}
