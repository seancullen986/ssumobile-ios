//
//  SSUCatalogTableViewController.swift
//  SSUMobile
//
//  Created by Jonathon Thompson on 5/8/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import Foundation

class SSUCatalogTableViewController: UITableViewController  {
    
    var context: NSManagedObjectContext = SSUScheduleModule.instance.context!
    var backgroundImageView: UIImageView?
    private var catalog: [SSUCourse]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        title = "SSU Catalog"
        
        if let image = UIImage(named: "table_background_image") {
            backgroundImageView = UIImageView(image: image)
            self.tableView.backgroundView = backgroundImageView
        }
        
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
        SSUScheduleModule.instance.updateData({
            self.loadSchedule()
        })
    }
    
    private func loadSchedule() {
        let fetchRequest: NSFetchRequest<SSUCourse> = SSUCourse.fetchRequest()
        
        do {
            catalog = try context.fetch(fetchRequest)
        } catch {
            SSULogging.logError("Error fetching schedule: \(error)")
            catalog = []
        }
        
        DispatchQueue.main.async {
            self.reloadScheduleTableView()
        }
    }
    
    private func reloadScheduleTableView() {
        tableView.reloadData()
    }
    
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = catalog?.count else {
            return 0
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseViewCell", for: indexPath)
        
        if let theCell = cell as? SSUCourseViewCell{
            theCell.transferClassInfo(course: (catalog![indexPath.row]))
            // theCell.layoutMargins = UIEdgeInsets.zero
            // theCell.separatorInset = UIEdgeInsets.zero
        }
        
        return cell
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
        if segue.identifier == "courseDetailView"{
            let cell = sender as! SSUCourseViewCell
            if let indexPath = tableView.indexPath(for: cell), let aClass = catalog?[(indexPath.row)] {
                
                print("CSTVC:\tprepare:\tsection = \((indexPath.section))\trow = \((indexPath.row))")
                print("printing oldClass:")
                
                let detailsVC = segue.destination as! SSUCourseDetailViewController
                detailsVC.passClassData(aClass)
            
            }
            
        }
    }
    
    
}
