//
//  ProfileViewController.swift
//  StockUp
//
//  Created by Abby Juan on 3/10/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignout(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error) -> Void in
            if(error != nil){
                print(error!.localizedDescription)
            }else{
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("loginViewController")
                self.presentViewController(vc, animated:true, completion:nil)
            }
        }
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
