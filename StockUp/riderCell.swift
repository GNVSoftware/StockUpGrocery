//
//  riderCell.swift
//  Stoc/Users/pranav/PranavBackUp/codePath/StockupGrocery/StockUp.xcodeprojkUp
//
//  Created by Pranav Achanta on 3/28/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit

class riderCell: UITableViewCell {
    
    // Outlets
    
    @IBOutlet weak var riderNameLabel: UILabel!
    
    @IBOutlet weak var riderPhoneLabel: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    
    @IBAction func onCall(sender: AnyObject) {
    
        if let url = NSURL(string: "tel://\(riderPhoneLabel.text!)") {
            UIApplication.sharedApplication().openURL(url)
        }
    
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.alpha = 1
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 1
        cardView.layer.shadowOffset = CGSizeMake(2,2)
        cardView.layer.shadowRadius = 1
        cardView.layer.shadowOpacity = 0.2
        let path = UIBezierPath()
        cardView.layer.shadowPath = path.CGPath
        
        self.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
