//
//  OnTheMapConvenience.swift
//  OnTheMap
//
//  Created by Florin Tudose on 26.03.15.
//  Copyright (c) 2015 FLO Media. All rights reserved.
//

import UIKit

import Foundation

// MARK: - Convenient Resource Methods

extension OnTheMapUdacityClient {
    

    func checkIfLoginSuccesfull(account: OnTheMapAccount, completionHandler: (success: Bool, returnKey: String?, errorString: String?) -> Void) {
        
        
        /* 2. Make the request */
        let task = taskForUdacityLOGIN(account) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(success: false, returnKey: "none", errorString: "Login Failed.")
            } else {
                
                if let result = JSONResult.valueForKey(OnTheMapUdacityClient.JSONBodyKeys.Account) as? NSDictionary{
                    if let isRegistered = result.valueForKey(OnTheMapUdacityClient.JSONResponseKeys.Registered) as? Bool{
                        var localKey = result.valueForKey(OnTheMapUdacityClient.JSONResponseKeys.Key) as! String
                        
                        completionHandler(success: true, returnKey: localKey, errorString: nil)
                    }
                   
                } else {
                    completionHandler(success: false, returnKey: "none", errorString: "Login Failed.")
                }
            }
        }
    }
    
    func getPublicUserDataFromAccount( account: OnTheMapAccount?, completionHandler: (success: Bool, parseDataObject: OnTheMapParseDataObject?, errorString: String?) -> Void) {
        
        
        /* 2. Make the request */
        let task = taskForUdacityGetUserData(account!) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(success: false, parseDataObject: nil, errorString: "Data Request Failed.")
            } else {
                var parsedObject: NSDictionary = JSONResult as! NSDictionary
                if let user = JSONResult.valueForKey(OnTheMapUdacityClient.JSONBodyKeys.User) as? NSDictionary {
                        
                    var localParseDataObject: OnTheMapParseDataObject?
                       
                    localParseDataObject = OnTheMapParseDataObject()

                    localParseDataObject!.lastName = user.valueForKey(OnTheMapUdacityClient.JSONResponseKeys.LastName) as? String
                        
                    localParseDataObject!.firstName = user.valueForKey(OnTheMapUdacityClient.JSONResponseKeys.FirstName) as? String
                        
                        
                    completionHandler(success: true, parseDataObject: localParseDataObject, errorString: nil)
                    
                    
                } else {
                    completionHandler(success: false,  parseDataObject: nil, errorString: "Data Request Failed.")
                }
            }
        }
    }

    
    
    
    
}