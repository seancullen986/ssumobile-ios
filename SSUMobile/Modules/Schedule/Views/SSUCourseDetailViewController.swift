//
//  ViewController.swift
//  tableviewExample
//
//  Created by Sean Cullen on 4/23/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import UIKit

class SSUCourseDetailViewController: UIViewController {
    var classData: SSUCourse?
    var backgroundImageView: UIImageView?
    // var building: SSUBuilding?
    var buildingTapGesture: UITapGestureRecognizer?
    var personTapGesture: UITapGestureRecognizer?
    
    // Outlets to storyboard
    @IBOutlet weak var departmentView: UIView!
    @IBOutlet weak var _className: UILabel!
    
    @IBOutlet weak var primaryInfoView: UIView!
    @IBOutlet weak var _description: UILabel!
    // @IBOutlet weak var _className: UILabel!
    @IBOutlet weak var _location: UILabel!
    @IBOutlet weak var _building: UILabel!
    @IBOutlet weak var _room: UILabel!
    @IBOutlet weak var _instructor: UILabel!
    @IBOutlet weak var _days: UILabel!
    @IBOutlet weak var _time: UILabel!
    
    @IBOutlet weak var secondaryInfoView: UIView!
    @IBOutlet weak var _component: UILabel!
    @IBOutlet weak var _units: UILabel!
    @IBOutlet weak var _combinedSection: UILabel!
    @IBOutlet weak var _designation: UILabel!
    @IBOutlet weak var _section: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
         
         let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ClassScheduleTVC") as! ClassScheduleTableViewController
         
         self.present(resultViewController, animated:true, completion:nil)
         */
        title = classData?.department
        //        backgroundImageView = UIImageView(frame: self.view.bounds)
        //        backgroundImageView?.image = UIImage(named: "DetailsBackgroundImage")
        //        self.view.addSubview(backgroundImageView!)
        
        

       // buildingTapGesture = UITapGestureRecognizer(target: self._building, action: #selector(self.handleBuildingClick(_:)))
        //personTapGesture = UITapGestureRecognizer(target: self._instructor, action: #selector(self.handlePersonClick(_:)))
        
        //        _building.addGestureRecognizer(tapGesture!)
        roundViewCorners()
        displayClassData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func handleBuildingClick(sender: UITapGestureRecognizer){
        performSegue(withIdentifier: "building", sender: self)
    }
    
    
    func handlePersonClick(sender: UITapGestureRecognizer){
        performSegue(withIdentifier: "person", sender: self)
    }
    
    
    func passClassData(_ course: SSUCourse){
        classData = course
    }
    
    
    func displayClassData(){

        _className.text = (classData?.subject)! + " " + (classData?.catalog)!
        
        _description.text = classData?.description

        _instructor.text = "Instructor: " + (classData?.first_name)! + " " + (classData?.last_name)!
        _days.text = getDays(standardMeetingPattern: (classData?.meeting_pattern)!)
        _time.text = (classData?.start_time)! + "-" + (classData?.end_time)!
        
        if classData?.component == "ACT"{
            _component.text = "Activity"
        }
        else if classData?.component == "LEC"{
            _component.text = "Lecture"
        }
        else{
            _component.text = "Discussion"
        }
        _units.text = "Units: " + "\((classData?.max_units)!)"
        if ( (classData?.combined_section)! != "" ){
            _combinedSection.text = "Combined Section? Yes"
        }
        else{
            _combinedSection.text = "Combined Section? No"
        }
        _designation.text = "Designation: " + "\((classData?.designation)!)"
        _section.text = "Section " + "\((classData?.section)!)"
        
        if let f_id = classData?.facility_id {
            let add_details = SSUCourseDetailHelper.location(f_id)
            if let building = add_details.building { _building.text = building }
            if let room = add_details.room { _room.text = room }
        }

        
    }
    
    
    func roundViewCorners(){
        departmentView.layer.cornerRadius = 10
        departmentView.layer.borderColor = UIColorFromHex(rgbValue: 0x003268).cgColor // Dark blue
        departmentView.layer.borderWidth = 1
        
        primaryInfoView.layer.cornerRadius = 10
        primaryInfoView.layer.borderColor = UIColorFromHex(rgbValue: 0x003268).cgColor // Dark blue
        primaryInfoView.layer.borderWidth = 1
        
        secondaryInfoView.layer.cornerRadius = 10
        secondaryInfoView.layer.borderColor = UIColorFromHex(rgbValue: 0x003268).cgColor // Dark blue
        secondaryInfoView.layer.borderWidth = 1
    }
    
    
    func getDays(standardMeetingPattern: String) -> String{
        var meetingDays = [String]()
        var days = ""
        if (standardMeetingPattern.range(of: "M") != nil){
            meetingDays.append("Monday")
        }
        if (standardMeetingPattern.range(of: "T") != nil){
            meetingDays.append("Tuesday")
        }
        if (standardMeetingPattern.range(of: "W") != nil){
            meetingDays.append("Wednesday")
        }
        if (standardMeetingPattern.range(of: "R") != nil){
            meetingDays.append("Thursday")
        }
        if (standardMeetingPattern.range(of: "F") != nil){
            meetingDays.append("Friday")
        }
        for day in 0..<meetingDays.count{
            days += meetingDays[day]
            if day < meetingDays.count - 1{
                days += ", "
            }
        }
        return days
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "building"{
//            let building: SSUBuilding = SSUDirectoryBuilder.building(withName: (classData?.building)!, in: SSUDirectoryModule.instance.context)
//            let controller: SSUDirectoryViewController = segue.destination as! SSUDirectoryViewController
//            let predicate = NSPredicate(format: "building = %@", building)
//            controller.defaultPredicate = predicate
//            controller.entities = [SSUDirectoryEntityPerson, SSUDirectoryEntityDepartment, SSUDirectoryEntitySchool]
//            controller.loadEntityName(SSUDirectoryEntityDepartment, using: nil)
//        }
//        else if segue.identifier == "person"{
//            let person: SSUPerson = SSUDirectoryBuilder.personWithFirstName((classData?.first_name)!, (classData?.last_name)! , SSUDirectoryModule.instance.context)
//            let controller: SSUDirectoryViewController = segue.destination as! SSUDirectoryViewController
//            let predicate = NSPredicate(format: "person = %@", person)
//            controller.defaultPredicate = predicate
//            controller.entities = [SSUDirectoryEntityDepartment, SSUDirectoryEntityBuilding, SSUDirectoryEntitySchool]
//            controller.loadEntityName(SSUDirectoryEntityDepartment, using: nil)
//        }
//        else{
//            print("Unrecognized segue: \(segue)")
//        }
//
    }
    
}
