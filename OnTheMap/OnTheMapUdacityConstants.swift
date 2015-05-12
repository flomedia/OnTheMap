//
//  OnTheMapUdacityConstants.swift
//  OnTheMap
//
//  Created by Florin Tudose on 08.04.15.
//  Copyright (c) 2015 FLO Media. All rights reserved.
//

import Foundation


extension OnTheMapUdacityClient {
    
    // MARK: - Constants
    struct Constants {
        
        
        // MARK: URLs
        static let BaseURL : String = "http://www.udacity.com/api/"
        static let BaseURLSecure : String = "https://www.udacity.com/api/"
        static let SignupURL : String = "https://www.udacity.com/account/auth#!/signup"
        
    }
    // MARK: - Methods
    struct Methods {
        
        // MARK: Session
        static let Session = "session"
        
        // MARK: Users
        static let Users = "users"
        
    }
    
    // MARK: - URL Keys
    struct URLKeys {
        
        static let UserID = "<user_id>"
        
    }
    
    // MARK: - Parameter Keys
    struct ParameterKeys {
        
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
        
    }
    
    // MARK: - JSON Body Keys
    struct JSONBodyKeys {
        
        static let User = "user"
        static let Account = "account"
        static let Session = "session"
        static let Email = "email"
        
    }
    
    // MARK: - JSON Response Keys
    struct JSONResponseKeys {
        
        
        static let LastName = "last_name"
        static let FirstName = "first_name"
        
        
        static let Registered = "registered"
        static let Key = "key"
        
        
        static let ID = "id"
        static let Expiration = "expiration"
        
        static let Verified = "_verified"
        static let Address = "address"
        
    }
    
    
}