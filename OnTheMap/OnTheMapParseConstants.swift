//
//  OnTheMapParseConstants.swift
//  OnTheMap
//
//  Created by Florin Tudose on 08.04.15.
//  Copyright (c) 2015 FLO Media. All rights reserved.
//

import Foundation

extension OnTheMapParseClient {
    
    // MARK: - Constants
    struct Constants {
        
                
        // MARK: URLs
        static let BaseURL : String = "http://api.parse.com/1/classes/"
        static let BaseURLSecure : String = "https://api.parse.com/1/classes/"
    }
    
    // MARK: - Methods
    struct Methods {
        
        // MARK: StudentLocation
        static let StudentLocation = "StudentLocation"
        
        
    }
    
    // MARK: - URL Keys
    struct URLKeys {
        
        static let ObjectID = "<objectId>"
        
    }
    
    // MARK: - Parameter Keys
    struct RequestKeys {
        
        static let XParseApplicationIdName = "X-Parse-Application-Id"
        static let XParseApplicationIdValue = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        
        static let XParseRESTAPIKeyName = "X-Parse-REST-API-Key"
        static let XParseRESTAPIKeyValue = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    }
  
    
    // MARK: - JSON Body Keys
    struct JSONBodyKeys {
        
        static let Results = "results"
        
    }
    
    // MARK: - JSON Response Keys
    struct JSONResponseKeys {
        
        static let ObjectId = "objectId"
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let CreatedAt = "createdAt"
        static let UpdatedAt = "updatedAt"
        static let ACL = "ACL"
        
    }
    
    
}