//
//  User.swift
//  StockUp
//
//  Created by Pranav Achanta on 3/23/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import Foundation
import UIKit
import Parse

struct User {
    static var user : userType = userType()
    static var window : UIWindow?
    static var activeRideID : String?
    static var expiryTime : NSTimeInterval?
    static var tabBarController : UITabBarController?
    
    static func setUpUserProfile(){
        // Check if it's an active rider
        let activeStatus = PFUser.currentUser()?.objectForKey("isActive") as? Bool
        if (activeStatus != nil && activeStatus == true){
            let user = PFUser.currentUser()?.objectForKey("userType") as? String
            
            if (user != nil && user == "driver"){
                // Get the Active ID
                User.activeRideID = PFUser.currentUser()?.objectForKey("activeRideID") as? String
                User.user = userType.activeDriver
                User.setUpProfile()
            }else if ( user != nil && user == "rider") {
                // Get the Active ID
                User.activeRideID = PFUser.currentUser()?.objectForKey("activeRideID") as? String
                User.user = userType.activeRider
                User.setUpProfile()
            }
        }else{
            User.user = userType.inActive
            User.setUpProfile()
        }
    }
    
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
        searchViewController.tabBarItem.image = UIImage(named: "Search")
        let postViewController = poststoryboard.instantiateViewControllerWithIdentifier("postViewController") as! UINavigationController
        postViewController.tabBarItem.title = "Post a Ride"
        postViewController.tabBarItem.image = UIImage(named: "Compose")
        
        
        
        switch (user) {
        case userType.inActive :
            let inactiveViewController = storyboard.instantiateViewControllerWithIdentifier("inactiveViewController") as! UINavigationController
            inactiveViewController.tabBarItem.title = "Active Ride"
            
            
//            let tabBarController = UITabBarController()
            tabBarController?.setViewControllers([searchViewController, postViewController], animated: true)
//            tabBarController.viewControllers = [searchViewController, postViewController, inactiveViewController]
            tabBarController?.selectedViewController = searchViewController
            window?.rootViewController  = tabBarController
            window?.makeKeyAndVisible()
            
        case userType.activeRider :
            let activeRiderViewController = storyboard.instantiateViewControllerWithIdentifier("activeRiderNavController") as! UINavigationController
            activeRiderViewController.tabBarItem.title = "Active Ride"
            
//            let tabBarController = UITabBarController()
            tabBarController?.setViewControllers([activeRiderViewController], animated: true)
//            tabBarController.viewControllers = [searchViewController, postViewController, activeRiderViewController]
            tabBarController?.selectedViewController = activeRiderViewController
            window?.rootViewController  = tabBarController
            window?.makeKeyAndVisible()
            
            
        case userType.activeDriver :
            let activeDriverViewController = storyboard.instantiateViewControllerWithIdentifier("activeDriverViewController") as! UINavigationController
            activeDriverViewController.tabBarItem.title = "Active Ride"
            
//            let tabBarController = UITabBarController()
            tabBarController?.setViewControllers([activeDriverViewController], animated: true)
//            tabBarController.viewControllers = [searchViewController, postViewController, activeDriverViewController]
            tabBarController?.selectedViewController = activeDriverViewController
            
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
