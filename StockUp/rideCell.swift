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
    
    
    // Actions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
