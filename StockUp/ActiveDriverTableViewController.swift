//
//  ActiveDriverTableViewController.swift
//  StockUp
//
//  Created by Abby Juan on 3/27/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ActiveDriverTableViewController : PFQueryTableViewController {

    @IBOutlet weak var riderName: UILabel!
    @IBOutlet weak var riderPhone: UILabel!
    
    var riderIds : [String]!
    
    override init(style: UITableViewStyle, className: String?) {
        super.init(style: style, className: className)
        parseClassName = "_User"
        pullToRefreshEnabled = true
        paginationEnabled = true
        objectsPerPage = 25
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        parseClassName = "_User"
        pullToRefreshEnabled = true
        paginationEnabled = true
        objectsPerPage = 25
    }
    
    
    override func queryForTable() -> PFQuery {
        let userQuery = PFQuery(className: self.parseClassName!)
        
        if self.objects!.count == 0{
            userQuery.cachePolicy = .CacheThenNetwork
        }
        
        userQuery.whereKey("_id", containedIn: riderIds)
        
        return userQuery
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, riderid: PFObject?) -> PFTableViewCell? {
        let cellIdentifier = "PFTableViewCell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? PFTableViewCell
        if cell == nil {
            cell = PFTableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
        }
        
        // Configure the cell to show todo item with a priority at the bottom
        if let riderid = riderid {
            riderName.text = riderid["name"] as? String
            print(riderName.text)
            riderPhone.text = riderid["phone"] as? String
        }
        
        return cell
    }
}