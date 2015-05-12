//
//  OnTheMapParseConvenience.swift
//  OnTheMap
//
//  Created by Florin Tudose on 09.04.15.
//  Copyright (c) 2015 FLO Media. All rights reserved.
//

import Foundation
// MARK: - Convenient Resource Methods

extension OnTheMapParseClient {
    
    
    
    func getStudentsPins(completionHandler: (result: [OnTheMapParseDataObject]?, error: NSError?) -> Void) -> NSURLSessionDataTask? {
        
        
        /* 2. Make the request */
        let task = taskForParseGetStudentLocations() { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                if let results = JSONResult.valueForKey(OnTheMapParseClient.JSONBodyKeys.Results) as? [[String : AnyObject]] {
                    
                    var objects = OnTheMapParseDataObject.objectsFromResults(results)
                    
                    completionHandler(result: objects, error: nil)
                } else {
                    completionHandler(result: nil, error: NSError(domain: "getStudentsPins parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentsPins"]))
                }
            }
        }

        
        return task
    }
    
    func postStudentPin(object: OnTheMapParseDataObject, completionHandler: (result: Bool, error: NSError?) -> Void) -> NSURLSessionDataTask? {
        
        
        /* 2. Make the request */
        let task = taskForParsePostStudentLocations(object) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(result: false, error: NSError(domain: "postStudentPin", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not postStudentPin"]))
            } else {
                    completionHandler(result: true, error: nil)
            }
        }
        
        
        return task
    }

    
    
}