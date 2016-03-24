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

    override func viewDidLoad() {
        super.viewDidLoad()
        let query = PFQuery(className:"Request")
        query.getObjectInBackgroundWithId("string") {
            (Request : PFObject?, error: NSError?) -> Void in
        
        
        
        
        }
        
     
        
        query.findObjectsInBackgroundWithBlock {
            (comments: [PFObject]?, error: NSError?) -> Void in
            // comments now contains the comments for myPost
        }
        // Do any additional setup after loading the view.
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
