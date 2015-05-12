//
//  OnTheMapUdacityClient.swift
//  OnTheMap
//
//  Created by Florin Tudose on 08.04.15.
//  Copyright (c) 2015 FLO Media. All rights reserved.
//

import Foundation


class OnTheMapUdacityClient :  OnTheMapClient {
    
    
    
    // MARK: - POST
    
    func taskForUdacityLOGIN(account: OnTheMapAccount,  completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        
        
        
        /* 2/3. Build the URL and configure the request */
        let urlString = Constants.BaseURLSecure + Methods.Session
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"udacity\": {\"username\": \"\(account.username)\", \"password\": \"\(account.password)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        
        
        /* 4. Make the request */
        let task = self.session.dataTaskWithRequest(request) {data, response, downloadError in
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            if let error = downloadError {
                let newError = NSError(domain: "OnTheMap Error", code: 1, userInfo: nil)
                completionHandler(result: nil, error: downloadError)
            } else {
                let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))/* subset response data! */
                
                OnTheMapClient.parseJSONWithCompletionHandler(newData, completionHandler: completionHandler)
            }
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    func taskForUdacityGetUserData(account: OnTheMapAccount,  completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        
        
        
        /* 2/3. Build the URL and configure the request */
        let urlString = Constants.BaseURLSecure + Methods.Users + "/" + account.key
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        
        
        
        /* 4. Make the request */
        let task = self.session.dataTaskWithRequest(request) {data, response, downloadError in
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            if let error = downloadError {
                let newError = NSError(domain: "OnTheMap Error", code: 1, userInfo: nil)
                completionHandler(result: nil, error: downloadError)
            } else {
                let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))/* subset response data! */
                
                OnTheMapClient.parseJSONWithCompletionHandler(newData, completionHandler: completionHandler)
            }
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    

    // MARK: - Shared Instance
    
    class func sharedInstance() -> OnTheMapUdacityClient {
        
        struct Singleton {
            static var sharedInstance = OnTheMapUdacityClient()
        }
        
        return Singleton.sharedInstance
    }

    

}