//
//  OnTheMapParseDataObject.swift
//  OnTheMap
//
//  Created by Florin Tudose on 09.04.15.
//  Copyright (c) 2015 FLO Media. All rights reserved.
//

import Foundation

struct OnTheMapParseDataObject {
    
    var objectId: String? = nil
    var uniqueKey: String? = nil
    var firstName: String? = nil
    var lastName: String? = nil
    var mapString: String? = nil
    var mediaURL: String? = nil
    var latitude: Double? = nil
    var longitude: Double? = nil
    var createdAt: String? = nil
    var updatedAt: String? = nil
    var ACL: String? = nil
   
    /* Construct a OnTheMapParseDataObject from a dictionary */
    init(dictionary: [String : AnyObject]) {
        
        objectId = dictionary[OnTheMapParseClient.JSONResponseKeys.ObjectId] as? String
        uniqueKey = dictionary[OnTheMapParseClient.JSONResponseKeys.UniqueKey] as? String
        firstName = dictionary[OnTheMapParseClient.JSONResponseKeys.FirstName] as? String
        lastName = dictionary[OnTheMapParseClient.JSONResponseKeys.LastName] as? String
        mapString = dictionary[OnTheMapParseClient.JSONResponseKeys.MapString] as? String
        mediaURL  = dictionary[OnTheMapParseClient.JSONResponseKeys.MediaURL] as? String
        latitude = dictionary[OnTheMapParseClient.JSONResponseKeys.Latitude] as? Double
        longitude = dictionary[OnTheMapParseClient.JSONResponseKeys.Longitude] as? Double
        createdAt = dictionary[OnTheMapParseClient.JSONResponseKeys.CreatedAt] as? String
        updatedAt = dictionary[OnTheMapParseClient.JSONResponseKeys.UpdatedAt] as? String
        ACL = dictionary[OnTheMapParseClient.JSONResponseKeys.ACL] as? String
        
       
    }
    
    
    init() {
        objectId = ""
        uniqueKey = ""
        firstName = ""
        lastName = ""
        mapString = ""
        mediaURL = ""
        latitude = 0.0
        longitude = 0.0
        createdAt = ""
        updatedAt = ""
        ACL = ""
    }
    
    /* Helper: Given an array of dictionaries, convert them to an array of OnTheMapParseDataObject objects */
    static func objectsFromResults(results: [[String : AnyObject]]) -> [OnTheMapParseDataObject] {
        var objects = [OnTheMapParseDataObject]()
        
        for result in results {
            objects.append(OnTheMapParseDataObject(dictionary: result))
        }
        
        return objects
    }
    
    func fillUserDataFromUdacityJsonResponse(jsonResponse: NSDictionary){
    }
    
}