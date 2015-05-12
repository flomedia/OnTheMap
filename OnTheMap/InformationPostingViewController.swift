//
//  InformationViewController.swift
//  OnTheMap
//
//  Created by Florin Tudose on 25.03.15.
//  Copyright (c) 2015 FLO Media. All rights reserved.
//

import UIKit
import CoreLocation

class InformationPostingViewController: UIViewController {
    
    @IBOutlet weak var locationTextField: UITextField!
    
    var appDelegate: AppDelegate!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        /* Get the app delegate */
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onFindOnTheMap(sender: UIButton) {
        
        
        
        if Reachability.isConnectedToNetwork() == false{
            let alert = Alert()
            alert.displayDismissAlert("No Internet :(", message: "Your internet connection seems to be down. Please try again later.", parent: self)
            return
        }
    
        
        let geoCoder = CLGeocoder()
        var placemark: AnyObject
        var error: NSError
        geoCoder.geocodeAddressString(locationTextField.text, completionHandler: { (placemark, error) -> Void in
            if error != nil {
                println("Error: \(error.localizedDescription)")
                
                let alert = Alert()
                alert.displayDismissAlert("Error", message: "Could not find the location you entered. Please check it again.", parent: self)
                return
            }
            if placemark.count > 0 {
                let pm = placemark[0] as! CLPlacemark
                
                self.appDelegate.parseDataObject!.mapString = self.locationTextField.text
                self.appDelegate.parseDataObject!.latitude = pm.location.coordinate.latitude
                self.appDelegate.parseDataObject!.longitude = pm.location.coordinate.longitude
                
                if  let controller = self.storyboard!.instantiateViewControllerWithIdentifier("SubmitLocationViewController") as? SubmitLocationViewController {
                    
                    
                    self.presentViewController(controller, animated: true, completion: nil)
                   
                }
                
                
            } else {
                println("Error with data")
            }
        })
        
    }
    
   

    
    
}