//
//  rideCell.swift
//  StockUp
//
//  Created by Pranav Achanta on 3/17/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit

class rideCell: UITableViewCell {
    // Outlets
    @IBOutlet weak var destinationLabel: UILabel!
    
    @IBOutlet weak var destAddressLabel: UILabel!
    
    @IBOutlet weak var driverNameLabel: UILabel!
    
    @IBOutlet weak var seatsLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    
    
    
    // Actions
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
