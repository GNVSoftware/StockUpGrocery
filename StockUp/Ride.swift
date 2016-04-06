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
import SwiftyJSON

class Ride: NSObject {
    
    //Properties
    var postId : String
    var destination : String
    var destAddress : String
    var driverId : String
    var driver : String
    var seats : Int16
    var price : Int16
    var time : Int16
    var destinationPlaceID : String
    var destinationRating : Float
    
    init(ride : JSON){
        // code goes here
        self.postId = ride["_id"].stringValue
        self.destination = ride["destinationName"].stringValue
        self.destAddress = ride["destinationAddress"].stringValue
        self.driverId = ride["driverID"]["_id"].stringValue
        self.driver = ride["driverID"]["name"].stringValue
        self.seats = ride["seatsAvailable"].int16Value
        self.price = ride["price"].int16Value
        self.time = ride["departuredTime"].int16Value
        self.destinationPlaceID = ride["destinationPlaceID"].stringValue
        self.destinationRating = ride["placeRating"].floatValue
    }
}
