//
//  ShowLocationViewController.swift
//  OnTheMap
//
//  Created by Florin Tudose on 27.04.15.
//  Copyright (c) 2015 FLO Media. All rights reserved.
//

import UIKit

import MapKit
import CoreLocation


class SubmitLocationViewController: UIViewController {
    
    
    @IBOutlet weak var linkText: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var submitLocation: UIButton!
    
    var appDelegate: AppDelegate!
    
  
    
    

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        /* Get the app delegate */
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addStudentPinToMap()
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let reuseId = "pin"
        
        var studentPin = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if studentPin == nil {
            studentPin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            studentPin!.animatesDrop = true
            studentPin!.pinColor = .Red
            
        }
        else {
            studentPin!.annotation = annotation
        }
        
        return studentPin
    }
    func addStudentPinToMap(){
        
        mapView!.removeAnnotations(mapView!.annotations)
        
        
        var currPin:MKPointAnnotation = MKPointAnnotation()
            
        let latitude = self.appDelegate.parseDataObject!.latitude
        let longitude = self.appDelegate.parseDataObject!.longitude
        currPin.coordinate = CLLocationCoordinate2DMake(latitude!,longitude!)
        mapView!.addAnnotation(currPin)
        
        
    }
    //used this: http://stackoverflow.com/questions/29106005/url-validation-in-swift
    func validateLink(link: String) -> Bool
    {
        if var url = NSURL(string: link) {
            return true
        }

        return false
    }
    
    @IBAction func onSubmitButton(sender: UIButton) {
        
        self.appDelegate.parseDataObject!.mediaURL = linkText.text
        
        if validateLink(linkText.text) == false{
            let alert = Alert()
            alert.displayDismissAlert("Error", message: "Entered Link is not valid. Please check it again.", parent: self)
            return
        }
        
        let task = OnTheMapParseClient.sharedInstance().postStudentPin(self.appDelegate!.parseDataObject!) { result, error in
            
            if result == true {
                
                if  let controller = self.storyboard!.instantiateViewControllerWithIdentifier("ManagerNavigationController") as? UINavigationController {
                    
                    self.presentViewController(controller, animated: true, completion: nil)
                }
            }
            else
            {
                let alert = Alert()
                 alert.displayDismissAlert("Error", message: "Could not post location data to the server. Please try again later.", parent: self)
            }
        }

    }
}