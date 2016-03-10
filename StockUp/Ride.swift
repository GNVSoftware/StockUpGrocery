//
//  Ride.swift
//  StockUp
//
//  Created by Franky Liang on 3/10/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit
import Parse
import GoogleMaps

class Ride: NSObject {
    
    func postRide(destination: GMSPlace, price: Int, seatsAvailable: Int, withCompletion completion: PFBooleanResultBlock?) {
        let newRide = PFObject(className:"Ride")
        
        newRide["price"] = price
        newRide["seatsAvailable"] = seatsAvailable
        newRide["departuredTime"] = 5 //temporary
       // newRide["destinationLongitude"] = destination.longitude
       // newRIde["destinationLatitude"] = destination.latitude
        newRide["destinationAddress"] = destination.formattedAddress!.componentsSeparatedByString(", ").joinWithSeparator("\n")
        
        let destPoint = PFGeoPoint(latitude:destination.coordinate.latitude, longitude:destination.coordinate.longitude )
        newRide["destinationCoordinate"] = destPoint
        
      
        
        
        newRide["destinationName"] = destination.name
        //newRide["driver"] = PFUser.currentUser()
        
        newRide.saveInBackgroundWithBlock(completion)
    }
    
}
