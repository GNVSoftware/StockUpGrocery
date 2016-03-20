//
//  rideDetailViewController.swift
//  StockUp
//
//  Created by Pranav Achanta on 3/18/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit

class rideDetailViewController: UIViewController {
    
    var ride : Ride!
    
    //Outlets
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var destionation: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var destAddress: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var driverName: UILabel!
    
    @IBOutlet weak var contactLabel: UILabel!
    
    @IBOutlet weak var phone: UILabel!
    
    //Actions
    @IBAction func onRequest(sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
