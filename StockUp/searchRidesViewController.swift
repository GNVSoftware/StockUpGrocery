//
//  searchRidesViewController.swift
//  StockUp
//
//  Created by Pranav Achanta on 3/17/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

class searchRidesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    var rides : [Ride]?
    @IBOutlet weak var tableView: UITableView!
    var locationManager: CLLocationManager!
    var currentLocation: CLLocationCoordinate2D!
    var locationSet = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 100
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Location Manager Specific Methods
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedAlways {
            locationManager.stopUpdatingLocation()
            locationManager.startUpdatingLocation()
        }
    }
    
    
    // Location Manager Service
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Try to Do Something here
        if let location = locations.first {
            if(!locationSet){
                currentLocation = location.coordinate
                locationSet = true
                networkCall()
            }
        }
    }
    
    func locationManager(manager: CLLocationManager,
        didFailWithError error: NSError){
            print("Error while updating location " + error.localizedDescription)
    }
    
    func networkCall(){
        let lat = currentLocation.latitude
        let long = currentLocation.longitude
        let url = NSURL(string:"http://stockupgrocery.herokuapp.com/searchRides?userLatitude=\(lat)&userLongitude=\(long)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    // Using the JSON Library
                    let responseDictionary = JSON(data : data)
                    var rides = [Ride]()
                    // Create the Movie Objects and add them to the movie array
                    for(_,ride) : (String, JSON) in responseDictionary["rides"]{
                        // Create an movie object for each json
                        let ride = Ride(ride: ride)
                        rides.append(ride)
                    }
                    self.rides = rides
                    self.tableView.reloadData()
                }
        });
        task.resume()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Table View Methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table View Cell Code goes here
        let cell = tableView.dequeueReusableCellWithIdentifier("rideCell", forIndexPath: indexPath) as! rideCell
        
        let ride = rides![indexPath.row]
        cell.destinationLabel.text = ride.destination
        cell.destAddressLabel.text = ride.destAddress
        cell.driverNameLabel.text = ride.driver
        cell.seatsLabel.text = String(ride.seats)
        cell.timeLabel.text = String(ride.time)
        cell.priceLabel.text = String(ride.price)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rides = rides{
            return rides.count
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
