//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Florin Tudose on 24.03.15.
//  Copyright (c) 2015 FLO Media. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
  
    
    @IBOutlet weak var theMap: MKMapView!
    var studentPins = [OnTheMapParseDataObject]()
    let locationManager = CLLocationManager()
    var lastCoordinate = CLLocationCoordinate2D()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.theMap.delegate = self
        
       
        
       
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "tapRefresh")
        
        self.parentViewController?.navigationItem.rightBarButtonItem = refreshButton
       
        let postButton = UIBarButtonItem(image: UIImage(named: "Pin"), style: UIBarButtonItemStyle.Plain, target: self, action: "tapPost")
        
        
        self.parentViewController?.navigationItem.leftBarButtonItem = postButton
    }
    
    override func viewDidAppear(animated: Bool) {
        
        dispatch_async(dispatch_get_main_queue(), {
            
        self.getCurrentLocation()
        });
        self.loadStudentPinsFromParse()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        lastCoordinate = manager.location.coordinate
        self.adjustRegion( lastCoordinate.latitude, aLongitude: lastCoordinate.longitude)
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        println(error.localizedDescription)
    }
    func getCurrentLocation()
    {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.stopMonitoringSignificantLocationChanges()
            locationManager.stopUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
            locationManager.startUpdatingLocation()
        }
        
        
    }
    
    
    func adjustRegion(aLatitude:CLLocationDegrees, aLongitude: CLLocationDegrees){
        
        locationManager.stopUpdatingLocation()
        locationManager.stopMonitoringSignificantLocationChanges()
        
        
        theMap!.removeAnnotations(theMap!.annotations)
        
        var latitude:CLLocationDegrees = aLatitude
        var longitude:CLLocationDegrees = aLongitude
        var latDelta:CLLocationDegrees = 30.0
        var longDelta:CLLocationDegrees = 30.0
        
        var aSpan:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta,longitudeDelta: longDelta)
        var Center :CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(Center, aSpan)
        
        self.theMap.setRegion(region, animated: true)
    }
    func refreshStudentPinsOnMap(){
        
        theMap!.removeAnnotations(theMap!.annotations)
        
        var counter:Int
        
        counter = 0
        for studentPin in self.studentPins {
            
            if  counter==100{
                break;
            }
           
             var currPin:MKPointAnnotation = MKPointAnnotation()
            
            let latitude = studentPin.latitude!
            let longitude = studentPin.longitude!
            currPin.coordinate = CLLocationCoordinate2DMake(latitude,longitude)
            currPin.title =  "\(studentPin.firstName!) \(studentPin.lastName!)"
            currPin.subtitle = studentPin.mediaURL
            
            theMap!.addAnnotation(currPin)

             counter++
            
        }
    
    }
    func loadStudentPinsFromParse(){
        
        let task = OnTheMapParseClient.sharedInstance().getStudentsPins  { studentPins, error in
            
            if let studentPins = studentPins {
                self.studentPins = studentPins
                dispatch_async(dispatch_get_main_queue(), {
                    
                   self.refreshStudentPinsOnMap()
                })
                
                }
        }
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
            studentPin!.canShowCallout = true
            studentPin!.animatesDrop = true
            studentPin!.pinColor = .Red
            
            
            var annotationTapButton: AnyObject! = UIButton.buttonWithType(UIButtonType.DetailDisclosure)
            
            annotationTapButton.titleForState(UIControlState.Normal)
            
            studentPin!.rightCalloutAccessoryView = annotationTapButton as! UIView
            
        }
        else {
            studentPin!.annotation = annotation
        }
        
        return studentPin
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!,
        calloutAccessoryControlTapped control: UIControl!) {
            
            if control == view.rightCalloutAccessoryView {
                 UIApplication.sharedApplication().openURL(NSURL(string: view.annotation.subtitle!)!)
            }
            
    }
    func tapRefresh(){
        
       
        dispatch_async(dispatch_get_main_queue(), {
            
        self.getCurrentLocation()
        })
        self.loadStudentPinsFromParse()
    }
    
    func tapPost(){
        
        if  let controller = self.storyboard!.instantiateViewControllerWithIdentifier("InformationPostingViewController") as? InformationPostingViewController {
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
}