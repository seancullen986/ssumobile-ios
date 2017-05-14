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
    
    var building: SSUBuilding?
    var person: SSUPerson?
    
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
    
    @IBOutlet weak var instructorButton: UIButton!
    @IBOutlet weak var buildingButton: UIButton!
    
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
        
        

//        buildingTapGesture = UITapGestureRecognizer(target: self.buildingButton, action: #selector(self.handleBuildingClick(_:)))
//        personTapGesture = UITapGestureRecognizer(target: self.instructorButton, action: #selector(self.handlePersonClick(_:)))
//        
//        _building.addGestureRecognizer(buildingTapGesture!)
//        _instructor.addGestureRecognizer(personTapGesture!)
        
        instructorButton.addTarget(self, action: #selector(handlePersonClick), for: .touchUpInside)
        buildingButton.addTarget(self, action: #selector(handleBuildingClick), for: .touchUpInside)
        
        roundViewCorners()
        displayClassData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func handleBuildingClick(/*_ sender: UITapGestureRecognizer*/){
        print("Reached handleBuildingClick function")
        performSegue(withIdentifier: "building", sender: self)
    }
    
    
    func handlePersonClick(/*_ sender: UITapGestureRecognizer*/){
        print("Reached handlePersonClick function")
        performSegue(withIdentifier: "person", sender: self)
    }
    
    
    func passClassData(_ course: SSUCourse){
        classData = course
        dump(classData)
    }
    
    
    func displayClassData(){
//        print("SCDVC\tdisplayClassData:\tprinting class data")

        if classData?.subject == nil || classData?.catalog == nil{  _className.text = "Class Name: TBD" }
        else{   _className.text = (classData?.subject)! + " " + (classData?.catalog)!   }
        
        
        _description.text = (classData?.description)!

        
        if classData?.first_name == nil || classData?.last_name == nil{     _instructor.text = "Instructor: Staff"  }
        else{   _instructor.text = "Instructor: " + (classData?.first_name)! + " " + (classData?.last_name)!    }
        
        
        if classData?.meeting_pattern == nil{   _days.text = "Meeting Days: TBD"    }
        else{   _days.text = getDays(standardMeetingPattern: (classData?.meeting_pattern)!) }
        
        
        if ( classData?.start_time == nil || classData?.end_time == nil ){  _time.text = "Time TBD" }
        else{   _time.text = (classData?.start_time)! + "-" + (classData?.end_time)!    }
        
        
        switch (classData?.component)! {
        case "ACT":
            _component.text = "Activity"
        case "LEC":
            _component.text = "Lecture"
        case "DIS":
            _component.text = "Discussion"
        case "SUP":
            _component.text = "Supervision"
        case "SEM":
            _component.text = "Seminar"
        default:
            _component.text = ""
        }

        if classData?.max_units == nil{
            
            if classData?.min_units == nil{ _units.text = "Units: TBD"  }
            else{   _units.text = "Units: " + "\((classData?.min_units)!)"  }
        }
        else{   _units.text = "Units: " + "\((classData?.max_units)!)"  }
        
        
        if ( classData?.combined_section == nil ){  _combinedSection.text = "Combined Section? No"  }
        else{   _combinedSection.text = "Combined Section? Yes" }
        
        
        if( classData?.designation == nil ){    _designation.text = "Designation: TBD"  }
        else{   _designation.text = "Designation: " + "\((classData?.designation)!)"    }
        
        
        if( classData?.section == nil){ _section.text = "Section: TBD"  }
        else{   _section.text = "Section " + "\((classData?.section)!)" }
        
        
        if let f_id = classData?.facility_id {
            print("facility id = \((classData?.facility_id)!)")
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
        var days = "Meeting Days: "
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
        if segue.identifier == "building"{
            if let f_id = classData?.facility_id {
                let add_details = SSUCourseDetailHelper.location(f_id)
                let Building = add_details.building
                let Room = add_details.room
            
                // let vc = SSUDirectoryViewController()
                // vc.reloadData()
                
                building = SSUDirectoryBuilder.building(withName: (Building)!, in: SSUDirectoryModule.instance.context)
                // let directoryController = segue.destination as! SSUDirectoryViewController
                // directoryController.reloadData()
                let controller = segue.destination as! SSUBuildingViewController
                
                // controller.loadObject(self.building, in: self.building?.managedObjectContext)
                controller.loadObject(self.building, in: SSUDirectoryModule.instance.context)
                // self.building?.managedObjectContext)
                
                
                // directoryController.displayObject(building)
                // let predicate = NSPredicate(format: "building = %@", building)
                // controller.defaultPredicate = predicate
                // controller.entities = [SSUDirectoryEntityPerson, SSUDirectoryEntityDepartment, SSUDirectoryEntitySchool]
                // controller.loadEntityName(SSUDirectoryEntityBuilding, using: nil)
            }
        }
        else if segue.identifier == "person"{
            person = SSUDirectoryBuilder.person(withFirstName: (classData?.first_name)!, andLastName: (classData?.last_name)! , in: SSUDirectoryModule.instance.context)
            let controller = segue.destination as! SSUPersonViewController
            controller.loadObject(self.person, in: self.person?.managedObjectContext)
            // let predicate = NSPredicate(format: "person = %@", person)
            // controller.defaultPredicate = predicate
            // controller.entities = [SSUDirectoryEntityDepartment, SSUDirectoryEntityBuilding, SSUDirectoryEntitySchool]
            // controller.loadEntityName(SSUDirectoryEntityPerson, using: nil)
        }
        else{
            print("CDVC\tUnrecognized segue: \(segue)")
        }

    }
    
}
