//
//  riderCell.swift
//  StockUp
//
//  Created by Pranav Achanta on 3/28/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit

class riderCell: UITableViewCell {
    
    // Outlets
    
    @IBOutlet weak var riderNameLabel: UILabel!
    
    @IBOutlet weak var riderPhoneLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
