//
//  rideDetailViewController.swift
//  StockUp
//
//  Created by Pranav Achanta on 3/18/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit
import Parse
import GoogleMaps
import Cosmos

class rideDetailViewController: UIViewController {
    
    var ride : Ride!
    var destPlaceID = ""
    var rating = 0.00
    //Outlets
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var destionation: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var destAddress: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var driverName: UILabel!
        
    @IBOutlet weak var cosmoView: CosmosView!
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
                request["driverID"] = self.ride.driverId
                request["riderID"] = PFUser.currentUser()?.objectId
                request["postID"] = self.ride.postId
                request.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        PFUser.currentUser()?.setValue(true, forKey: "isActive")
                        PFUser.currentUser()?.setValue("rider", forKey: "userType")
                        PFUser.currentUser()?.setValue(request.objectId!, forKey: "activeRideID")
                        PFUser.currentUser()?.saveInBackground()
                        
                        // Save the Active ID as the Request ID
                        User.activeRideID = request.objectId!
                        // Mark the User as a Rider
                        User.user = userType.activeRider
                        User.setUpProfile()
                        
                        
                        // Get the time for the timer
//                        let formatter = NSDateFormatter()
//                        formatter.dateFormat = "HH:mm"
//                        let postStartTime = formatter.dateFromString(post!["departureTime"] as! String)
//                        
//                        let expiryTime = NSDate().timeIntervalSinceDate(postStartTime!)
//                        
//                        User.expiryTime = expiryTime
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
    
    func delayedAction(){
        // Bring the State back to original state
        
        // What to do with the request!!.. Should we delete it or mark it
        // as inactive??
        
        User.user = userType.inActive
        User.setUpProfile()
    }
    
    
    func loadFirstPhotoForPlace(placeID: String) {
        GMSPlacesClient.sharedClient().lookUpPhotosForPlaceID(placeID) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.description)")
            } else {
                if let firstPhoto = photos?.results.first {
                    self.loadImageForMetadata(firstPhoto)
                }
            }
        }
    }
    
    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata) {
        GMSPlacesClient.sharedClient()
            .loadPlacePhoto(photoMetadata, constrainedToSize: imageView.bounds.size,
                scale: self.imageView.window!.screen.scale) { (photo, error) -> Void in
                    if let error = error {
                        // TODO: handle the error.
                        print("Error: \(error.description)")
                    } else {
                        self.imageView.image = photo;
                        //self.attributionTextView.attributedText = photoMetadata.attributions;
                    }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        destPlaceID = ride.destinationPlaceID
        

        // Do any additional setup after loading the view.
        destionation.text = ride.destination
        destAddress.text = ride.destAddress
        time.text = String(ride.time)
        price.text = String(ride.price)
        driverName.text = ride.driver
        loadFirstPhotoForPlace(destPlaceID)
        cosmoView.rating = Double(ride.destinationRating)
        cosmoView.settings.updateOnTouch = false
        cosmoView.settings.fillMode = .Precise
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
