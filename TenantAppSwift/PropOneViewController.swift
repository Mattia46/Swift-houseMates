//
//  PropOneViewController.swift
//  TenantAppSwift
//
//  Created by Alix on 03/01/2016.
//  Copyright © 2016 TenantTeam. All rights reserved.
//

import UIKit

class PropOneViewController: UIViewController {
    
    let loggedUser = LoggedUser.sharedInstance
    
    // Info provided at Sign Up
    
    @IBOutlet weak var loggedUserName: UILabel!
    @IBOutlet weak var loggedFullName: UILabel!
    @IBOutlet weak var loggedEmail: UILabel!
    
    // New Info
    
    @IBOutlet weak var locationArea: UITextField!
    @IBOutlet weak var postCode: UITextField!
    @IBOutlet weak var streetName: UITextField!
    @IBOutlet weak var propertyType: UITextField!
    @IBOutlet weak var contractStart: UITextField!
    @IBOutlet weak var contractEnd: UITextField!
    @IBOutlet weak var landLord: UITextField!
    @IBOutlet weak var landlordContact: UITextField!
    @IBOutlet weak var numberFlatMate: UITextField!
    @IBOutlet weak var rent: UITextField!
    @IBOutlet weak var deposit: UITextField!
    
    // Property one labels and buttons
    
    @IBOutlet weak var historyLabel: UILabel!
    
    @IBOutlet weak var proponeLabel: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation bar formatting
        
        let logo = UIImage(named: "logo2")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "419bd2")
        
        //Background colour
        
        self.view.backgroundColor = UIColor(hexString: "cbcbcc")

        self.loggedUserName.text = "Username: \(loggedUser.username)"
        self.loggedFullName.text = "Full name: \(loggedUser.firstname) \(loggedUser.lastname)"
        self.loggedEmail.text = loggedUser.email
        
        // Label and button background colour
        
        historyLabel.backgroundColor = UIColor(hexString: "419bd2")
        proponeLabel.backgroundColor = UIColor(hexString: "419bd2")
        
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
    
    
    @IBAction func savePropOne(sender: UIButton) {
        createNewProperty("PropOneComplete")
    }
    
    
    
    @IBAction func submitProfile(sender: UIButton) {
        createNewProperty("SubmitProfileOne")
    }
    

    
    func createNewProperty(segueIdentifier: String) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        let locationarea:NSString = locationArea.text!
        let postcode:NSString = postCode.text!
        let streetname:NSString = streetName.text!
        let propertytype:NSString = propertyType.text!
        let contractstart:NSString = contractStart.text!
        let contractend:NSString = contractEnd.text!
        let landlord:NSString = landLord.text!
        let landlordcontact:NSString = landlordContact.text!
        let numbermate: Int? = Int(numberFlatMate.text!)
        let proprent: Int? = Int(rent.text!)
        let propdeposit: Int? = Int(deposit.text!)
        
        
        if ( locationarea.isEqualToString("") || postcode.isEqualToString("") || streetname.isEqualToString("") || propertytype.isEqualToString("") || contractstart.isEqualToString("") || contractend.isEqualToString("") || landlord.isEqualToString("") || landlordcontact.isEqualToString("") || (numbermate == nil) || (proprent == nil) || (propdeposit == nil)) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Failed!"
            alertView.message = "Please enter full details"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
        } else {
            do {
        
        
        let session = NSURLSession.sharedSession()
        
        
        
        let newPropertyPost: NSDictionary = ["location_area": locationarea,"post_code":postcode,"street_name":streetname,"landlord_name":landlord,"landlord_contact_details":landlordcontact,"property_type":propertytype,"number_of_flatmates":numbermate!,"monthly_cost":proprent!,"deposit_amount":propdeposit!,"inclusive":false, "contract_start": contractstart, "contract_end": contractend]
        let path: String = "https://housematey.herokuapp.com/properties_only"
        let url = NSMutableURLRequest(URL: NSURL(string: path)!)
        url.HTTPMethod = "POST"
        
        // set new post as HTTPBody for request
        url.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        do {
            url.HTTPBody = try NSJSONSerialization.dataWithJSONObject(newPropertyPost, options: NSJSONWritingOptions())
            print(newPropertyPost)
            
            
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
            if let postString = NSString(data:data!, encoding: NSUTF8StringEncoding) as? String {
                // Print what we got from the call
                print("POST: " + postString)
                
            }
            
            let post: NSDictionary
            
            do { post = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                
                dispatch_async(dispatch_get_main_queue(),{
                    let propertyId = post["_id"] as! String
                    
                    let userProperties = UserProperties.sharedInstance
                    userProperties.props = [propertyId]
                    
                    self.assignNewProperty(userProperties.props)
                    self.performSegueWithIdentifier(segueIdentifier, sender: self)
                })
            } catch {
                print("error parsing response from post")
            }
        })
        task.resume()
    
            }
        }
}
    
    func assignNewProperty(properties: NSArray) {
        
        let session = NSURLSession.sharedSession()
        let newPropertyPut: NSDictionary = ["properties": properties]
        let path: String = "https://housematey.herokuapp.com/users/\(loggedUser.id)"
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
