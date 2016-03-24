//
//  User.swift
//  StockUp
//
//  Created by Pranav Achanta on 3/23/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import Foundation
import UIKit

struct User {
    static var user : userType = userType()
    static var window : UIWindow?
    static var activeRideID : String?
    
    static func setUpProfile(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let poststoryboard = UIStoryboard(name: "postRide", bundle: nil)
        let searchstoryboard = UIStoryboard(name: "searchRides", bundle: nil)
        
        // set the tabbar controller as a root vc instead of the nav bar. So i set myNav on the tabbar controller
        // when drag the connection to Home, you've already drag it to the nav .
        // set the Home as the first tab bar, so when you set tab bar controller as the root vc, the Home vc will be shown. m
        // if there is a logged in user then load the home view controller
        
        
        let searchViewController = searchstoryboard.instantiateViewControllerWithIdentifier("searchViewController") as! UINavigationController
        searchViewController.tabBarItem.title = "Search Rides"
        let postViewController = poststoryboard.instantiateViewControllerWithIdentifier("postViewController") as! UINavigationController
        postViewController.tabBarItem.title = "Post a Ride"
        
        switch (user) {
        case userType.inActive :
            let inactiveViewController = storyboard.instantiateViewControllerWithIdentifier("inactiveViewController") as! UINavigationController
            inactiveViewController.tabBarItem.title = "Active Ride"
            
            
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [searchViewController, postViewController, inactiveViewController]
            tabBarController.selectedViewController = inactiveViewController
            window?.rootViewController  = tabBarController
            window?.makeKeyAndVisible()
            
        case userType.activeRider :
            let activeRiderViewController = storyboard.instantiateViewControllerWithIdentifier("activeRiderViewController") as! UINavigationController
            activeRiderViewController.tabBarItem.title = "Active Ride"
            
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [searchViewController, postViewController, activeRiderViewController]
            tabBarController.selectedViewController = activeRiderViewController
            window?.rootViewController  = tabBarController
            window?.makeKeyAndVisible()
            
            
        case userType.activeDriver :
            let activeDriverViewController = storyboard.instantiateViewControllerWithIdentifier("activeDriverViewController") as! UINavigationController
            activeDriverViewController.tabBarItem.title = "Active Ride"
            
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [searchViewController, postViewController, activeDriverViewController]
            tabBarController.selectedViewController = activeDriverViewController
            
            window?.rootViewController  = tabBarController
            window?.makeKeyAndVisible()
        }
    }
}

enum userType {
    case inActive
    case activeDriver
    case activeRider
    
    init() {
        self = .inActive
    }
}
