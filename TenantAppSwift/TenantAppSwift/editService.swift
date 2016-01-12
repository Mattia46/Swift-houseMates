//
//  editService.swift
//  TenantAppSwift
//
//  Created by Mattia on 21/12/2015.
//  Copyright © 2015 TenantTeam. All rights reserved.
//

import Foundation

class editService {
    
    func editUser() {
        
        let session = NSURLSession.sharedSession()
        let newPropertyPut: NSDictionary = ["firstName": "Ugo"]
        let path: String = "https://housematey.herokuapp.com/users/567846de7f47911100f5c4a0"
        let url = NSMutableURLRequest(URL: NSURL(string: path)!)
        url.HTTPMethod = "PUT"
        
        // set new post as HTTPBody for request
        url.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        do {
            url.HTTPBody = try NSJSONSerialization.dataWithJSONObject(newPropertyPut, options: NSJSONWritingOptions())
            print(newPropertyPut)
            
        } catch {
            print("bad things happened")
        }
        
        // Make the POST call and handle it in a completion handler
        let task = session.dataTaskWithRequest(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            
            // Read the JSON
            if let putString = NSString(data:data!, encoding: NSUTF8StringEncoding) as? String {
                // Print what we got from the call
                print("PUT: " + putString)
                
            }
            
        })
        task.resume()
    }
    
    func editProperty() {
        
        let session = NSURLSession.sharedSession()
        let newPropertyPut: NSDictionary = ["post_code": "W3 6GG"]
        let path: String = "https://housematey.herokuapp.com/properties/5678440f7f47911100f5c494"
        let url = NSMutableURLRequest(URL: NSURL(string: path)!)
        url.HTTPMethod = "PUT"
        
        // set new post as HTTPBody for request
        url.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        do {
            url.HTTPBody = try NSJSONSerialization.dataWithJSONObject(newPropertyPut, options: NSJSONWritingOptions())
            print(newPropertyPut)
            
        } catch {
            print("bad things happened")
        }
        
        // Make the POST call and handle it in a completion handler
        let task = session.dataTaskWithRequest(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            
            // Read the JSON
            if let putString = NSString(data:data!, encoding: NSUTF8StringEncoding) as? String {
                // Print what we got from the call
                print("PUT: " + putString)
                
            }
            
        })
        task.resume()
    }
}