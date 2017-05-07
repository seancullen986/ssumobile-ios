//
//  SSUCourseViewCell.swift
//  SSUMobile
//
//  Created by Sean Cullen on 5/6/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import Foundation

import UIKit

class SSUCourseViewCell: UITableViewCell {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("CourseViewCell")
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
    func transferClassInfo(course: SSUCourse) {
        print("CourseViewCell:\ttransferClassInfo")
        var f = ""
        var l = ""
        //let cd = UILabel(frame: CGRect(x: 10, y: 0, width: 365, height: 30))
        // classDescription?.frame = CGRect(x: 10, y: 0, width: 365, height: 30)
        if let sub = course.subject { subject = sub }
        if let cat = course.catalog { catalog = cat }
        if let start = course.start_time { startTime = start }
        if let end = course.end_time { endTime = end }
        if let comp = course.component { component = comp }
        if let first = course.first_name { f = first }
        if let last = course.last_name { l = last }
        if ( f != "" && l != "") { instructor = f + " " + l }
        else if ( f != "" ) { instructor = f }
        else if ( l != "" ) { instructor = l }

        stringForCell()
        
        self.contentView.addSubview(ClassName!)
        self.contentView.addSubview(TimeFrame!)
        self.contentView.addSubview(Professor!)

    }
    
    func stringForCell(){
        ClassName.text = "\(subject!) \(catalog!) - \(component!)"
        TimeFrame.text = "\(startTime!)-\(endTime!)"
        Professor.text = "\(instructor!)"
    }
    
    
}
