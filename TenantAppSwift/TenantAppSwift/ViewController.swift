//
//  ViewController.swift
//  TenantAppSwift
//
//  Created by Alix on 17/12/2015.
//  Copyright © 2015 TenantTeam. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    // Sign In text field outlets
    
    @IBOutlet weak var usernameSignIn: UITextField!
    
    @IBOutlet weak var passwordSignIn: UITextField!
    
    @IBOutlet weak var signinButton: UIButton!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //Navigation bar formatting
            
            let logo = UIImage(named: "logo2")
            let imageView = UIImageView(image:logo)
            self.navigationItem.titleView = imageView
            self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "419bd2")
        
            
            //Background colour
            
            self.view.backgroundColor = UIColor(hexString: "cbcbcc")
            
            //Button colour
            
           signinButton.backgroundColor = UIColor(hexString: "419bd2")

            //Dismiss keyboard
            
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
            view.addGestureRecognizer(tap)
        

        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    // Sign In action
    // username ezzyetest
    // password ezzyetest
    
    
    @IBAction func signin(sender: UIButton) {
        
//        self.usernameSignIn.text = "RGeller"
//        self.passwordSignIn.text = "password"
        
        print("userName: \(usernameSignIn.text!)")
        print("password: \(passwordSignIn.text!)")
        
        //set end point
        let postEndpoint: String = "https://housematey.herokuapp.com/api/signin"
        let url = NSURL(string: postEndpoint)!
        let session = NSURLSession.sharedSession()
        
        
        print("postEndPoint: \(postEndpoint)")
        print("url: \(url)")
        print("session: \(session)")
        
        // Create the request
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        // No body needed
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        // However header needed
        request.setAuthorizationHeader(username: usernameSignIn.text!, password: passwordSignIn.text!)
        
        print("HTTPMethod: \(request.HTTPMethod)")
        
        // Make the GET call and handle it in a completion handler
        session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error:NSError?) -> Void in
            print("made request")
            // Make sure we get an OK response
            guard let response = response as? NSHTTPURLResponse where
                response.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            
            // Read the JSON
//            if let jsonString = NSString(data:data!, encoding: NSUTF8StringEncoding) as? String {
//                // Print what we got from the call
//                print("GET: " + jsonString)
//                        }
            
            let json = JSON(data: data!)
            
            print("GET: \(json)")
            
            dispatch_async(dispatch_get_main_queue(),{
                
                loggedUserService().setLoggedUserId(json)
                
                self.performSegueWithIdentifier("SignInComplete", sender: self)
                    
            })
            
        }).resume()
        
    }
    
    
}

extension NSMutableURLRequest {
    func setAuthorizationHeader(username username: String, password: String) -> Bool {
        guard let data = "\(username):\(password)".dataUsingEncoding(NSUTF8StringEncoding) else { return false }
        
        let base64 = data.base64EncodedStringWithOptions([])
        setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
        return true
        
//        self.performSegueWithIdentifier("SignInComplete", sender: self)
        
        
    }
}

