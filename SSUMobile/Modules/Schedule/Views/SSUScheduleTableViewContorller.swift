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
class ClassScheduleTableViewController: UITableViewController {
    
    var classes: [[Class]]?
    var backgroundImageView: UIImageView?
    //    var monday: [Class]?
    //    var tuesday: [Class]?
    //    var wednesday: [Class]?
    //    var thursday: [Class]?
    //    var friday: [Class]?
    //    @IBOutlet weak var _title: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // print("view did load\n")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        title = "My Class Schedule"
        // _title.textAlignment = .center
        let image = UIImage(named: "table_background_image")
        backgroundImageView = UIImageView(image: image)
        self.tableView.backgroundView = backgroundImageView
        
        
        let _classes = createMockClasses()
        organizeClasses(_classes: _classes)
        print("CSTVC:\tprinting all classes.")
        dump(classes)
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //        print("CSTVC:\tprinting all classes.")
        //        for _class in classes!{
        //            _class.printClass()
        //        }
        //        print("CSTVC:\tprinting monday classes.")
        //        for _class in (classes?[0])!{
        //            _class.printClass()
        //        }
        //        print("CSTVC:\tprinting tuesday classes.")
        //        for _class in (classes?[1])!{
        //            _class.printClass()
        //        }
        //        print("CSTVC:\tprinting wednesday classes.")
        //        for _class in (classes?[2])!{
        //            _class.printClass()
        //        }
        //        print("CSTVC:\tprinting thursday classes.")
        //        for _class in (classes?[3])!{
        //            _class.printClass()
        //        }
        //        print("CSTVC:\tprinting friday classes.")
        //        for _class in (classes?[4])!{
        //            _class.printClass()
        //        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // navigationItem.title = "My Class Schedule"
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
        // Dispose of any resources that can be recreated.
    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
    
    
    func createMockClasses() -> [Class]{
        let class1 = Class(_classNumber: 1, _department: "American Multicultural Studies", _subject: "AMCS", _catalog: "165A", _section: 1, _description: "Humanities Learning Community", _component: "LEC", _minUnits: 4, _maxUnits: 4, _startTime: "02:00 PM", _endTime: "03:50 PM", _standardMeetingPattern: "MWF", _firstName: "Vanilla", _lastName: "Ice", _combinedSection: "Combined Section", _descr: "Arts and Humanities", _facilityID: "STEV3008", _designation: "GE01")
        
        let class2 = Class(_classNumber: 2, _department: "American Multicultural Studies", _subject: "AMCS", _catalog: "165A", _section: 2, _description: "Humanities Learning Community", _component: "DIS", _minUnits: 3, _maxUnits: 3, _startTime: "04:00 PM", _endTime: "05:50 PM", _standardMeetingPattern: "TR", _firstName: "Tupac", _lastName: "Shakur", _combinedSection: "", _descr: "Arts and Humanities", _facilityID: "NICH0242", _designation: "GE01")
        
        let class3 = Class(_classNumber: 3, _department: "Psychology", _subject: "PSY", _catalog: "302", _section: 1, _description: "Lifespan", _component: "DIS", _minUnits: 3, _maxUnits: 3, _startTime: "04:00 PM", _endTime: "05:00 PM", _standardMeetingPattern: "W", _firstName: "Harambe", _lastName: "", _combinedSection: "Combined Section", _descr: "The Integrated Person", _facilityID: "DARW100", _designation: "GE01")
        
        let class4 = Class(_classNumber: 4, _department: "Womens Gender Studies", _subject: "WGS", _catalog: "255", _section: 1, _description: "Sex, Drugs, & Rock n' Roll", _component: "ACT", _minUnits: 3, _maxUnits: 3, _startTime: "09:00 AM", _endTime: "11:40 AM", _standardMeetingPattern: "F", _firstName: "Charlie", _lastName: "Sheen", _combinedSection: "", _descr: "Social Sciences", _facilityID: "IVES101", _designation: "GE01")
        
        let class5 = Class(_classNumber: 5, _department: "Sexual Education", _subject: "Sex-Ed", _catalog: "101", _section: 2, _description: "Some shit", _component: "ACT", _minUnits: 4, _maxUnits: 4, _startTime: "10:00 AM", _endTime: "11:50 AM", _standardMeetingPattern: "TR", _firstName: "Tiger", _lastName: "Woods", _combinedSection: "Combined Section", _descr: "Arts and Humanities", _facilityID: "SALZ2013", _designation: "GE01")
        
        return [class1, class2, class3, class4, class5]
    }
    
    
    func organizeClasses(_classes: [Class]){
        var mon = [Class]()
        var tues = [Class]()
        var wed = [Class]()
        var thurs = [Class]()
        var fri = [Class]()
        
        for _class in _classes{
            if (_class.standardMeetingPattern?.range(of: "M") != nil){
                // _class.printClass()
                mon.append(_class)
                print("Added this class to monday:")
                // mon[0].printClass()
            }
            if (_class.standardMeetingPattern?.range(of: "T") != nil){
                // _class.printClass()
                tues.append(_class)
                print("Added this class to tuesday:")
                // tues[0].printClass()
            }
            if (_class.standardMeetingPattern?.range(of: "W") != nil){
                // _class.printClass()
                wed.append(_class)
                print("Added this class to wednesday:")
                // wed[0].printClass()
            }
            if (_class.standardMeetingPattern?.range(of: "R") != nil){
                // _class.printClass()
                thurs.append(_class)
                print("Added this class to thursday:")
                // thurs[0].printClass()
            }
            if (_class.standardMeetingPattern?.range(of: "F") != nil){
                // _class.printClass()
                fri.append(_class)
                print("Added this class to friday:")
                // fri[0].printClass()
            }
            classes = [mon, tues, wed, thurs, fri]
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            classes?[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //        print(section)
        //        print(classes?[section].count)
        return (classes?[section].count)!
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassViewCell", for: indexPath)
        
        // Configure the cell...
        if let theCell = cell as? ClassViewCell{
            // print("CSTVC:\ttableView:\tindexPath.row:\t\(indexPath.row)")
            print("CSTVC:\ttableView:\tindexPath.section:\t\(indexPath.section)")
            theCell.transferClassInfo(_class: (classes?[indexPath.section][indexPath.row])!)
            // theCell.layoutMargins = UIEdgeInsets.zero
            // theCell.separatorInset = UIEdgeInsets.zero
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0:
            return "Monday"
        case 1:
            return "Tuesday"
        case 2:
            return "Wednesday"
        case 3:
            return "Thursday"
        case 4:
            return "Friday"
        default:
            return ""
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        // header.textLabel?.font = UIFont(name: "Futura", size: 11)
        // header.backgroundColor = UIColorFromHex(rgbValue: 0xf7f7f7)
        header.contentView.backgroundColor = UIColorFromHex(rgbValue: 0x215EA8)
        header.textLabel?.textColor = UIColorFromHex(rgbValue: 0xFFFFFF)
        header.textLabel?.textAlignment = .center
    }
    
    
    
    //    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let view = UIView()
    //        view.backgroundColor = UIColorFromHex(rgbValue: 0x215EA8)
    //        return view
    //
    //    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "classToDetails"{
            let cell = sender as! ClassViewCell
            if let indexPath = tableView.indexPath(for: cell), let oldClass = classes?[(indexPath.section)][(indexPath.row)]{
                
                print("CSTVC:\tprepare:\tsection = \((indexPath.section))\trow = \((indexPath.row))")
                print("printing oldClass:")
                // oldClass?.printClass()
                let detailsVC = segue.destination as! ClassDetailsViewController
                detailsVC.passClassData(_class: oldClass)
            }
            
        }
    }
    
    
}
