//
//  ActiveDriverViewController.swift
//  StockUp
//
//  Created by Pranav Achanta on 3/28/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit
import Parse

class ActiveDriverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // DataSource
    var riders : [PFObject]?
    
    // Table View
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        // Call Parse and get the Data
        let query = PFQuery(className: "Request")
        query.whereKey("postID", equalTo : User.activeRideID!)
        query.findObjectsInBackgroundWithBlock { (requests : [PFObject]?, error: NSError?) -> Void in
            // List of Requests
            if (requests != nil && error == nil){
                var riderIds = [String]()
                for req in requests!{
                    riderIds.append(req["riderID"] as! String)
                }
                
                let userQuery = PFQuery(className: "_User")
                userQuery.whereKey("_id", containedIn: riderIds)
                
                userQuery.findObjectsInBackgroundWithBlock({ (riders : [PFObject]?, error : NSError?) in
                    if (riders != nil && error == nil){
                        self.riders = riders
                        self.tableView.reloadData()
                    }
                })
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("riderCell") as! riderCell
        
        let rider = riders![indexPath.row]
        cell.riderNameLabel.text = rider["name"] as? String
        cell.riderPhoneLabel.text = rider["phone"] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Code to come here
        if riders != nil{
            return riders!.count
        }else{
            return 0
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
