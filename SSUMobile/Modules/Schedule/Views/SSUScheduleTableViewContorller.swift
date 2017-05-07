//
//  SSUScheduleTableViewContorller.swift
//  SSUMobile
//
//  Created by Jonathon Thompson on 5/6/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import Foundation

// basic features   -Done
// need to make a "details" view for each table cell and a button to access each one    -Done
// need to make an edit button to delete classes    -Done
// need to add an extension to a search page
// add in "break" UIViews between non-back-to-back classes (if time permits)
class SSUScheduleTableViewController: UITableViewController  {
    
    var context: NSManagedObjectContext = SSUScheduleModule.instance.context!
    var backgroundImageView: UIImageView?
    private var schedule: [SSUSchedule]?
    private var sects: [Sections]?
    
    private struct Sections {
        var title: String
        var courses = [SSUCourse]()
        var count = 0
        init(title: String, course: SSUCourse) {
            self.title = title
            addOrIgnore(course)
            
        }
        mutating func addOrIgnore(_ course: SSUCourse) {
            if ( !(courses.contains(where: { $0.id == course.id })) ) {
                self.courses.append(course)
                count = count + 1
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        title = "My Class Schedule"

        if let image = UIImage(named: "table_background_image") {
            backgroundImageView = UIImageView(image: image)
            self.tableView.backgroundView = backgroundImageView
        }
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        refresh()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.flashScrollIndicators()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
    
    private func refresh() {
        SSUScheduleModule.instance.updateData(completion: {
            self.loadSchedule()
        })
    }
    
    private func loadSchedule() {
        let fetchRequest: NSFetchRequest<SSUCourse> = SSUCourse.fetchRequest()
        
        do {
            schedule = try context.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [SSUSchedule]
        } catch {
            SSULogging.logError("Error fetching schedule: \(error)")
            schedule = []
        }
        
        DispatchQueue.main.async {
            self.reloadScheduleTableView()
        }
    }
    
    private func reloadScheduleTableView() {
        tableView.reloadData()
    }

    private func getCoursesInSchedule() {
        for course in schedule! {
            if let aCourse = SSUCourseBuilder.course(withID: Int(course.id), inContext: context),
                let days = getDays(aCourse) {
                for day in days {
                    if ( !((sects?.contains(where: { $0.title == day}))!) ) {
                        sects?.append(Sections(title: day, course: aCourse))
                    }
                }
            }
        }
    }
    
    
    func getDays(_ course: SSUCourse) -> [String]? {
        var days: [String]?
        
        if (course.meeting_pattern?.range(of: "M") != nil){
            days!.append("Monday")
        }
        if (course.meeting_pattern?.range(of: "T") != nil){
            days!.append("Tuesday")
        }
        if (course.meeting_pattern?.range(of: "W") != nil){
            days!.append("Wednesday")
        }
        if (course.meeting_pattern?.range(of: "R") != nil){
            days!.append("Thursday")
        }
        if (course.meeting_pattern?.range(of: "F") != nil){
            days!.append("Friday")
        }

        return days
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (sects?.count)!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sects?[section].count)!
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            sects?[indexPath.section].courses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            // TODO: Actually delete class
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseViewCell", for: indexPath)
        
        if let theCell = cell as? SSUCourseViewCell{
            theCell.transferClassInfo(course: (sects?[indexPath.section].courses[indexPath.row])!)
            // theCell.layoutMargins = UIEdgeInsets.zero
            // theCell.separatorInset = UIEdgeInsets.zero
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sects?[section].title
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        // header.textLabel?.font = UIFont(name: "Futura", size: 11)
        // header.backgroundColor = UIColorFromHex(rgbValue: 0xf7f7f7)
        header.contentView.backgroundColor = UIColorFromHex(rgbValue: 0x215EA8)
        header.textLabel?.textColor = UIColorFromHex(rgbValue: 0xFFFFFF)
        header.textLabel?.textAlignment = .center
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "courseToDetails"{
            let cell = sender as! SSUCourseViewCell
            if let indexPath = tableView.indexPath(for: cell), let oldClass = sects?[(indexPath.section)].courses[(indexPath.row)] {
                
                print("CSTVC:\tprepare:\tsection = \((indexPath.section))\trow = \((indexPath.row))")
                print("printing oldClass:")

                let detailsVC = segue.destination as! SSUCourseDetailViewController
                detailsVC.passClassData(oldClass)
            }
            
        }
    }
    
    
}
