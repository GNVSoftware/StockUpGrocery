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
    var destination : String
    var destAddress : String
    var driver : String
    var seats : Int16
    var price : Int16
    var time : Int16
    
    init(ride : JSON){
        // code goes here
        self.destination = ride["destinationName"].stringValue
        self.destAddress = ride["destinationAddress"].stringValue
        self.driver = ride["driverID"]["name"].stringValue
        self.seats = ride["seatsAvailable"].int16Value
        self.price = ride["price"].int16Value
        self.time = ride["departureTime"].int16Value
    }
}
