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

class postRidesViewController: UIViewController, CLLocationManagerDelegate,  UIPickerViewDataSource, UIPickerViewDelegate {
    var priceOptions = [ "0.00", "1.00", "2.00", "3.00", "4.00", "5.00", "6.00", "7.00", "8.00", "9.00", "10.00"]
    
    var seatsOption = [ "1", "2", "3", "4", "5", "6"]
    var locationManager: CLLocationManager!
    /*
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    */
    @IBOutlet weak var nameLabel: UILabel!
    var time = ""
    @IBOutlet weak var addressLabel: UILabel!
    var placesClient: GMSPlacesClient!
    var price = 1.0
    var seatsAvail = 1
    var postRide = Post()
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var seatsTextField: UITextField!
    var destination: GMSPlace?
    var placePicker: GMSPlacePicker?
    var currentLocation : GMSPlace?
    var currentPoint: PFGeoPoint?
    var pricePickerView = UIPickerView()
    var seatPickerView = UIPickerView()
    
    
    @IBOutlet weak var dateField: UITextField!
    var currentLat = 0.0
    var currentLong = 0.0
    
    
    // Actions
    @IBAction func onLogOut(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error) -> Void in
            if(error != nil){
                print(error!.localizedDescription)
            }else{
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("loginViewController")
                self.presentViewController(vc, animated:true, completion:nil)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pricePickerView.delegate = self
        seatPickerView.delegate = self
        
        priceTextField.inputView = pricePickerView
        seatsTextField.inputView = seatPickerView
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
                    self.currentLocation = currentplace
                    self.currentPoint = PFGeoPoint(latitude: currentplace.coordinate.latitude, longitude: currentplace.coordinate.longitude)
                    self.currentLat = currentplace.coordinate.latitude
                    self.currentLong = currentplace.coordinate.longitude
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
    
    @IBAction func dateField(sender: UITextField) {
        let datePicker : UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Time
        sender.inputView = datePicker
         datePicker.addTarget(self, action: #selector(postRidesViewController.datePicker(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    func datePicker(sender: UIDatePicker) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .NoStyle
        timeFormatter.timeStyle = .ShortStyle
        dateField.text = timeFormatter.stringFromDate(sender.date)
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pricePickerView {
            return priceOptions[row]
        } else {
            return seatsOption[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pricePickerView {
            return priceOptions.count
        } else {
            return seatsOption.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pricePickerView {
            priceTextField.text = priceOptions[row]
        } else {
           seatsTextField.text = seatsOption[row]
        }
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
    
    @IBAction func onTapView(sender: AnyObject) {
        view.endEditing(true)
    }
    @IBAction func clickPost(sender: AnyObject) {
//        EZLoadingActivity.show("Loading...", disableUI: false)
        if (destination!.name != "" && seatsAvail != 0) {
            price = Double(priceTextField.text!)!
            seatsAvail = Int(seatsTextField.text!)!
            time = dateField.text!
           
            let dateAsString = time
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            let date = dateFormatter.dateFromString(dateAsString)
            
            dateFormatter.dateFormat = "HH:mm"
            let milTimeDate = dateFormatter.stringFromDate(date!)
            
            let milTime = dateFormatter.dateFromString(milTimeDate)
            
            
            postRide.postRide(destination!, currentLocation: currentLocation!, currentLatitude: currentLat, currentLongitude: currentLong, price: price, seatsAvailable: seatsAvail, milTimeDate: milTime!)
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