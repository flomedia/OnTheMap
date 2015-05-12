//
//  ViewController.swift
//  OnTheMap
//
//  Created by Florin Tudose on 23.03.15.
//  Copyright (c) 2015 FLO Media. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UILabel!
    @IBOutlet weak var signInWithFacebook: UIButton!
    
    var appDelegate: AppDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* Get the app delegate */
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonTouch(sender: AnyObject) {
        appDelegate.account!.username = usernameField.text
        appDelegate.account!.password = passwordField.text
        let alert = Alert()
        
        if Reachability.isConnectedToNetwork() == false{
            alert.displayDismissAlert("No Internet :(", message: "Your internet connection seems to be down. Please try again later.", parent: self)
        }
       
        OnTheMapUdacityClient.sharedInstance().checkIfLoginSuccesfull(self.appDelegate.account!) { (success, returnKey, errorString) in
            if success {
                self.appDelegate.account!.key = returnKey!
                self.appDelegate.parseDataObject!.uniqueKey = returnKey!
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.completeLogin()
                })
            } else {
                 dispatch_async(dispatch_get_main_queue(), {
                    alert.displayDismissAlert("Wrong credentials", message: "Your username or password are wrong. Please try again.", parent: self)
                    })

                self.displayError(errorString)
            }
        }
    }
    
    @IBAction func signUpButton(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.udacity.com/account/auth#!/signup")!)
        
        
    }
    
    func getUserData()
    {
        OnTheMapUdacityClient.sharedInstance().getPublicUserDataFromAccount(self.appDelegate.account) { (success, returnParseDataObject, errorString) in
            if success {
                self.appDelegate.parseDataObject!.firstName = returnParseDataObject!.firstName
                self.appDelegate.parseDataObject!.lastName = returnParseDataObject!.lastName
            } else {
                self.displayError(errorString)
            }
        }

    }
    func completeLogin() {

        getUserData()
            
        if  let controller = self.storyboard!.instantiateViewControllerWithIdentifier("ManagerNavigationController") as? UINavigationController {
            
            self.presentViewController(controller, animated: true, completion: nil)
        }
      
    }
    
    func displayError(errorString: String?) {
 
            if let errorString = errorString {
                
            }

    }
    
   
}

