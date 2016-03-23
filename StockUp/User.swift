//
//  User.swift
//  StockUp
//
//  Created by Pranav Achanta on 3/23/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import Foundation

struct User {
    static var user : userType = userType()
}

enum userType {
    case inActive
    case activeDriver
    case activeRider
    
    init() {
        self = .inActive
    }
}
