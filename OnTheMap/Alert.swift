//
//  Alert.swift
//  OnTheMap
//
//  Created by Florin Tudose on 06.05.15.
//  Copyright (c) 2015 FLO Media. All rights reserved.
//
import UIKit

public class Alert {
    
    func displayDismissAlert(title: String, message: String, parent: UIViewController)
    {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        parent.presentViewController(alert, animated: true, completion: nil)
    }
}