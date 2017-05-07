//
//  SSUCourseViewCell.swift
//  SSUMobile
//
//  Created by Jonathon Thompson on 5/6/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import Foundation

// Author: Sean Cullen
// Course: CS 470
// Instructor: Kooshesh
// Assignment: Artist Project
//
//  ArtistTableViewCell.swift
//  ArtistsInTableView
//
//  Created by AAK on 3/25/16.
//  Copyright © 2016 SSU. All rights reserved.
//

import UIKit

class ClassViewCell: UITableViewCell {
    var subject: String?
    var catalog: String?
    var startTime: String?
    var endTime: String?
    var instructor: String?
    var component: String?
    // var className: UILabel!
    
    
    @IBOutlet weak var ClassName: UILabel!
    @IBOutlet weak var TimeFrame: UILabel!
    @IBOutlet weak var Professor: UILabel!
    //    @IBOutlet weak var ClassName: UILabel!
    //    @IBOutlet weak var TimeFrame: UILabel!
    //    @IBOutlet weak var Professor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("ClassViewCell")
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColorFromHex(rgbValue: 0x003268).cgColor // Dark blue
        self.layer.borderWidth = 1
        // self.layer.backgroundColor = UIColorFromHex(rgbValue: 0x98BEE8).cgColor
        // self.layer.backgroundColor = UIColorFromHex(rgbValue: 0xFFFFFF).cgColor
        self.layer.backgroundColor = UIColorFromHex(rgbValue: 0xFFFFFF).withAlphaComponent(0.6).cgColor
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func transferClassInfo(_class: Class) {
        print("ClassViewCell:\ttransferClassInfo")
        //let cd = UILabel(frame: CGRect(x: 10, y: 0, width: 365, height: 30))
        // classDescription?.frame = CGRect(x: 10, y: 0, width: 365, height: 30)
        subject = _class.subject!
        catalog = _class.catalog!
        startTime = _class.startTime!
        endTime = _class.endTime!
        instructor = _class.firstName! + " " + _class.lastName!
        component = _class.component!
        stringForCell()
        
        self.contentView.addSubview(ClassName!)
        self.contentView.addSubview(TimeFrame!)
        self.contentView.addSubview(Professor!)
        // print("Added subviews")
        //        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        //        cellImage.isUserInteractionEnabled = true
        //        cellImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func stringForCell(){
        ClassName.text = "\(subject!) \(catalog!) - \(component!)"
        TimeFrame.text = "\(startTime!)-\(endTime!)"
        Professor.text = "\(instructor!)"
        //        Label.text = "\(subject!) \(catalog!) - \(component!)\n\(startTime!)-\(endTime!)\n\(instructor!)"
    }
    
    
}
//    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
//    {
//        let tappedImage = tapGestureRecognizer.view as! UIImageView
//
//        // Your action
//
//        var popup = UITextView(frame: super.frame)
//        popup.text = "\(profile)"
//        super.addSubview(popup)
//        UIView.animate(withDuration: 1.0, animations: {
//            popup.alpha = 1.0
//        })
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileTapped(tapGestureRecognizer:)))
//        popup.isUserInteractionEnabled = true
//        popup.addGestureRecognizer(tapGestureRecognizer)
//
//        print("\(profile!)")
//    }
//
//    func profileTapped(tapGestureRecognizer: UITapGestureRecognizer){
//        UIView.animate(withDuration: 1.0, animations: {
//            self.alpha = 1.0
//        })
//    }

