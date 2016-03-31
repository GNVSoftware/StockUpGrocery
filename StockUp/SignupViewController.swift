//
//  SignupViewController.swift
//  StockUp
//
//  Created by Abby Juan on 3/10/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit
import Parse


class SignupViewController: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancelButton(sender: AnyObject) {
        self.performSegueWithIdentifier("cancelSegue", sender: nil)
    
    }
    
    @IBAction func createaccountButton(sender: AnyObject) {
        let newUser = PFUser()
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        newUser["phone"] = phoneTextField.text
        newUser["name"] = nameTextField.text
        newUser.signUpInBackgroundWithBlock { (success: Bool,error: NSError?) -> Void in
            if success {
                print("created a new user")
                print(newUser["phone"])
                print(newUser["name"])
                User.tabBarController = UITabBarController()
                User.setUpUserProfile()
            }  else {
                print(error?.localizedDescription)
                if error?.code == 202 {
                    print("Username is taken")
                }else{
//                    var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
//                    alert.show()
                    // New Alert View Controller
                    
                    // create the alert
                    let alert = UIAlertController(title: "UIAlertController", message: "\(error)", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    // add the actions (buttons)
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
                    
                    // show the alert
                    self.presentViewController(alert, animated: true, completion: nil)
                }
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
