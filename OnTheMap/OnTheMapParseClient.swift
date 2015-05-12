//
//  OnTheMapParseClient.swift
//  OnTheMap
//
//  Created by Florin Tudose on 08.04.15.
//  Copyright (c) 2015 FLO Media. All rights reserved.
//

import Foundation



class OnTheMapParseClient :  OnTheMapClient {
    
    
    
    // MARK: - POST
 
    
    
    func taskForParseGetStudentLocations(completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
       
        
        /* 2/3. Build the URL and configure the request */
        let urlString = Constants.BaseURLSecure + Methods.StudentLocation
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        
        request.addValue(RequestKeys.XParseApplicationIdValue, forHTTPHeaderField: RequestKeys.XParseApplicationIdName)
        request.addValue(RequestKeys.XParseRESTAPIKeyValue, forHTTPHeaderField: RequestKeys.XParseRESTAPIKeyName)
        
        
        /* 4. Make the request */
        let task = self.session.dataTaskWithRequest(request) {data, response, downloadError in
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            if let error = downloadError {
                let newError = NSError(domain: "OnTheMap Parse Error", code: 1, userInfo: nil)
                completionHandler(result: nil, error: downloadError)
            } else {
                
                
                OnTheMapClient.parseJSONWithCompletionHandler(data, completionHandler: completionHandler)
            }
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    func taskForParsePostStudentLocations(object: OnTheMapParseDataObject, completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        
       
        
        
        /* 2/3. Build the URL and configure the request */
        let urlString = Constants.BaseURLSecure + Methods.StudentLocation
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        request.addValue(RequestKeys.XParseApplicationIdValue, forHTTPHeaderField: RequestKeys.XParseApplicationIdName)
        request.addValue(RequestKeys.XParseRESTAPIKeyValue, forHTTPHeaderField: RequestKeys.XParseRESTAPIKeyName)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"\(JSONResponseKeys.UniqueKey)\": \"\(object.uniqueKey)\", \"\(JSONResponseKeys.FirstName)\": \"\(object.firstName)\", \"\(JSONResponseKeys.LastName)\": \"\(object.lastName)\",\"\(JSONResponseKeys.MapString)\": \"\(object.mapString)\", \"\(JSONResponseKeys.MediaURL)\": \"\(object.mediaURL)\",\"\(JSONResponseKeys.Latitude)\": \(object.latitude), \"\(JSONResponseKeys.Longitude)\": \(object.longitude)}".dataUsingEncoding(NSUTF8StringEncoding)

        
        /* 4. Make the request */
        let task = self.session.dataTaskWithRequest(request) {data, response, downloadError in
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            if let error = downloadError {
                let newError = NSError(domain: "OnTheMap Error", code: 1, userInfo: nil)
                completionHandler(result: nil, error: downloadError)
            } else {
                
                
                OnTheMapClient.parseJSONWithCompletionHandler(data, completionHandler: completionHandler)
            }
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    func taskForParseQuerryStudentLocations(completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        
        
        
        /* 2/3. Build the URL and configure the request */
        let urlString = Constants.BaseURLSecure + Methods.StudentLocation + "?where=%7B%22uniqueKey%22%3A%221234%22%7D"
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        
        
        request.addValue(RequestKeys.XParseApplicationIdValue, forHTTPHeaderField: RequestKeys.XParseApplicationIdName)
        request.addValue(RequestKeys.XParseRESTAPIKeyValue, forHTTPHeaderField: RequestKeys.XParseRESTAPIKeyName)
        
        
        /* 4. Make the request */
        let task = self.session.dataTaskWithRequest(request) {data, response, downloadError in
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            if let error = downloadError {
                let newError = NSError(domain: "OnTheMap Error", code: 1, userInfo: nil)
                completionHandler(result: nil, error: downloadError)
            } else {
                
                
                OnTheMapClient.parseJSONWithCompletionHandler(data, completionHandler: completionHandler)
            }
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    func taskForParsePutStudentLocations(object: OnTheMapParseDataObject, completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
       
      
        
        /* 2/3. Build the URL and configure the request */
        let urlString = Constants.BaseURLSecure + Methods.StudentLocation + "/\(object.objectId)"
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "PUT"
        request.addValue(RequestKeys.XParseApplicationIdValue, forHTTPHeaderField: RequestKeys.XParseApplicationIdName)
        request.addValue(RequestKeys.XParseRESTAPIKeyValue, forHTTPHeaderField: RequestKeys.XParseRESTAPIKeyName)

        request.HTTPBody = "{\"\(JSONResponseKeys.ObjectId)\": \"\(object.objectId)\", \"\(JSONResponseKeys.FirstName)\": \"\(object.firstName)\", \"\(JSONResponseKeys.LastName)\": \"\(object.lastName)\",\"\(JSONResponseKeys.MapString)\": \"\(object.mapString)\", \"\(JSONResponseKeys.MediaURL)\": \"\(object.mediaURL)\",\"\(JSONResponseKeys.Latitude)\": \(object.latitude), \"\(JSONResponseKeys.Longitude)\": \(object.longitude)}".dataUsingEncoding(NSUTF8StringEncoding)
        
        /* 4. Make the request */
        let task = self.session.dataTaskWithRequest(request) {data, response, downloadError in
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            if let error = downloadError {
                let newError = NSError(domain: "OnTheMap Error", code: 1, userInfo: nil)
                completionHandler(result: nil, error: downloadError)
            } else {
                
                
                OnTheMapClient.parseJSONWithCompletionHandler(data, completionHandler: completionHandler)
            }
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    // MARK: - Shared Instance
    
    class func sharedInstance() -> OnTheMapParseClient {
        
        struct Singleton {
            static var sharedInstance = OnTheMapParseClient()
        }
        
        return Singleton.sharedInstance
    }

}