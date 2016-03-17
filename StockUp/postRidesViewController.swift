//
//  postRidesViewController.swift
//  StockUp
//
//  Created by Franky Liang on 3/10/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit
import Parse
import GoogleMaps

class postRidesViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    /*
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    */
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    var placesClient: GMSPlacesClient!
    var price = 1
    var seatsAvail = 1
//    var rideModel = Ride()
    var postRide = Post()
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var seatsTextField: UITextField!
    var destination: GMSPlace?
    var placePicker: GMSPlacePicker?
    
    var currentPoint: PFGeoPoint?
    
    var currentLat = 0.0
    var currentLong = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        let subView = UIView(frame: CGRectMake(0, 65.0, 350.0, 45.0))
        
        subView.addSubview((searchController?.searchBar)!)
        self.view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        self.definesPresentationContext = true
        */
        
        // Do any additional setup after loading the view.
        //let destPoint = PFGeoPoint(latitude:destination.coordinate.latitude, longitude:destination.coordinate.longitude )
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        placesClient = GMSPlacesClient()
        
        placesClient.currentPlaceWithCallback({ (placeLikelihoods, error) -> Void in
            guard error == nil else {
                print("Current Place error: \(error!.localizedDescription)")
                return
            }
            
            if let placeLikelihoods = placeLikelihoods {
                print("place")
                for likelihood in placeLikelihoods.likelihoods {
                    let currentplace = likelihood.place
                    
                    self.currentPoint = PFGeoPoint(latitude: currentplace.coordinate.latitude, longitude: currentplace.coordinate.longitude)
                    self.currentLat = currentplace.coordinate.latitude
                    self.currentLong = currentplace.coordinate.longitude
                    
                    print("Current Place name \(currentplace.name) at likelihood \(likelihood.likelihood)")
                    print("Current Place address \(currentplace.formattedAddress)")
                    print("Current Place attributions \(currentplace.attributions)")
                    print("Current PlaceID \(currentplace.placeID)")
                }
            } else {
                print("nil")
            }
            
        })
        
    
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func pickPlace(sender: UIButton) {
        let center = CLLocationCoordinate2DMake(currentLat, currentLong)
        let northEast = CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001)
        let southWest = CLLocationCoordinate2DMake(center.latitude - 0.001, center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        placePicker = GMSPlacePicker(config: config)
        
        placePicker?.pickPlaceWithCallback({ (place: GMSPlace?, error: NSError?) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let place = place {
                self.destination = place
                self.nameLabel.text = place.name
                self.addressLabel.text = place.formattedAddress!.componentsSeparatedByString(", ").joinWithSeparator("\n")
            } else {
                self.nameLabel.text = "No place selected"
                self.addressLabel.text = ""
            }
        })
    }
    
    @IBAction func clickPost(sender: AnyObject) {
        //EZLoadingActivity.show("Loading...", disableUI: false)
        if (destination!.name != "" && seatsAvail != 0) {
            
            price = Int(priceTextField.text!)!
            
            seatsAvail = Int(priceTextField.text!)!
            
            postRide.postRide(destination!, currentLatitude: currentLat, currentLongitude: currentLong, price: price, seatsAvailable: seatsAvail, withCompletion: { (success: Bool, error: NSError?) -> Void in
                if let error = error {
                    print(error.localizedDescription)
                    
                    
                } else {
                    print("Posted Ride Successfully")
                    //EZLoadingActivity.hide()
                    
                }
            })
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
// Handle the user's selection.
/*
extension ViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(resultsController: GMSAutocompleteResultsViewController,
        didAutocompleteWithPlace place: GMSPlace) {
            searchController?.active = false
            // Do something with the selected place.
            print("Place name: ", place.name)
            print("Place address: ", place.formattedAddress)
            print("Place attributions: ", place.attributions)
            
            destination = place
    }
    
    func resultsController(resultsController: GMSAutocompleteResultsViewController,
        didFailAutocompleteWithError error: NSError){
            // TODO: handle the error.
            print("Error: ", error.description)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictionsForResultsController(resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictionsForResultsController(resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}
*/