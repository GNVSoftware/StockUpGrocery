//
//  rideDetailViewController.swift
//  StockUp
//
//  Created by Pranav Achanta on 3/18/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit
import Parse

class rideDetailViewController: UIViewController {
    
    var ride : Ride!
    
    //Outlets
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var destionation: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var destAddress: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var driverName: UILabel!
        
    // Segue Controller
    
    //Actions
    @IBAction func onRequest(sender: AnyObject) {
        // create a nee request for the post
        // Get the post for that id
        let query = PFQuery(className:"Post")
        query.getObjectInBackgroundWithId(ride.postId) {
            (post : PFObject?, error: NSError?) -> Void in
            if error == nil && post != nil {
                // Reduce the number of spots left!!
                let request = PFObject(className:"Request")
                request["postId"] = self.ride.postId
                request["rider"] = PFUser.currentUser()?.objectId
                request.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        //
                        print("request posted successfully")
                        
                        // Mark the User as a Rider
                        User.user = userType.activeRider
                        // Redirect the User to active rides page
                        self.tabBarController?.selectedIndex = 2
                    } else {
                        // There was a problem, check error.description
                        print("error in sending the request")
                    }
                }
            } else {
                print(error)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        destionation.text = ride.destination
        destAddress.text = ride.destAddress
        time.text = String(ride.time)
        price.text = String(ride.price)
        driverName.text = ride.driver
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
