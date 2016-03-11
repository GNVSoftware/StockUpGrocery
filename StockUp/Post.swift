//
//  Post.swift
//  StockUp
//
//  Created by Franky Liang on 3/10/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit
import Parse
import GoogleMaps

class Post: NSObject {
    
    
    func postRide(destination: GMSPlace, currentLatitude: Double, currentLongitude: Double, price: Int, seatsAvailable: Int, withCompletion completion: PFBooleanResultBlock?) {
        let newRide = PFObject(className:"Post")
        
        newRide["price"] = price
        newRide["seatsAvailable"] = seatsAvailable
        newRide["departuredTime"] = 5 //temporary
        
        newRide["destinationAddress"] = destination.formattedAddress!.componentsSeparatedByString(", ").joinWithSeparator("\n")
        
        let destPoint = PFGeoPoint(latitude:destination.coordinate.latitude, longitude:destination.coordinate.longitude )
        newRide["destinationLatitude"] = destination.coordinate.latitude
        newRide["destinationLongitude"] = destination.coordinate.longitude
        
        
        newRide["currentLatitude"] = currentLatitude
        newRide["currentLongitude"] = currentLongitude
        
        
        newRide["destinationName"] = destination.name
        newRide["driver"] = PFUser.currentUser()
        
        
        newRide["fromLocation"] = [currentLatitude, currentLongitude]
        
        newRide["destinationLocation"] = [destination.coordinate.latitude, destination.coordinate.longitude]
        
        newRide.saveInBackgroundWithBlock(completion)
    }

}
