//
//  ActiveRiderViewController.swift
//  StockUp
//
//  Created by Abby Juan on 3/23/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit
import Parse

class ActiveRiderViewController: UIViewController {

   
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFQuery(className:"Request")
        query.getObjectInBackgroundWithId(User.activeRideID!) {
            (request : PFObject?, error: NSError?) -> Void in
            if error == nil && request != nil {
            let postid = request!["postID"] as! String
            let driverid = request!["driverID"]as! String
                
            let query2 = PFQuery(className:"Post")
            query2.getObjectInBackgroundWithId(postid){ (post : PFObject?, error: NSError?) -> Void in
                        // Do something with the post info
                if  error == nil && request != nil{
                
            self.destinationLabel.text = post!["destinationName"] as? String
            print(self.destinationLabel.text)
            self.priceLabel.text = String(post!["doublePrice"] as! Double)
            post!.saveInBackground()
       
            print(driverid)//prints current driverid
            print(postid)//prints current postid
                }
            }
                
            let query3 = PFQuery(className:"_User")
            query3.getObjectInBackgroundWithId(driverid, block: { (user : PFObject?, error: NSError?) -> Void in
                    // Do something with the driver info
            self.nameLabel.text = user!["name"] as? String
            self.phoneLabel.text = user!["phone"] as? String
            user!.saveInBackground()
            })
                
                
    
            }
        
        
        
        }
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
