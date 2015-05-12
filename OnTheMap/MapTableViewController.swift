//
//  MapListViewController.swift
//  OnTheMap
//
//  Created by Florin Tudose on 24.03.15.
//  Copyright (c) 2015 FLO Media. All rights reserved.
//

import UIKit

class MapTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var studentPins = [OnTheMapParseDataObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
       
        let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "tapRefresh")
        
        self.parentViewController?.navigationItem.rightBarButtonItem = refreshButton
        
        
        let postButton = UIBarButtonItem(image: UIImage(named: "Pin"), style: UIBarButtonItemStyle.Plain, target: self, action: "tapPost")
        
        self.parentViewController?.navigationItem.leftBarButtonItem = postButton

        
        self.loadStudentPinsFromParse()
            

            
       
        
        }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.studentPins.count<100{
            return self.studentPins.count
        }
        else{
            return 100
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MapStudent") as! UITableViewCell

        
        
        let studentPin = self.studentPins[indexPath.row]
        
        // Set the name and image
        cell.textLabel?.text = "\(studentPin.firstName!) \(studentPin.lastName!)"
        cell.imageView?.image = UIImage(named:"Pin")
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MapTableViewController")! as! MapTableViewController
            let studentPin  = self.studentPins[indexPath.row]
            UIApplication.sharedApplication().openURL(NSURL(string: studentPin.mediaURL!)!)
        
    }
    
    
    func loadStudentPinsFromParse(){
        
        let task = OnTheMapParseClient.sharedInstance().getStudentsPins  { studentPins, error in
            
            if let studentPins = studentPins {
                self.studentPins = studentPins
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    // DO SOMETHING ON THE MAINTHREAD
                    self.tableView.reloadData()
                })
            }
        }
    }

    
    func tapRefresh(){
        
        self.loadStudentPinsFromParse()
       
    }
    func tapPost(){
        
        if  let controller = self.storyboard!.instantiateViewControllerWithIdentifier("InformationPostingViewController") as? InformationPostingViewController {
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
}
