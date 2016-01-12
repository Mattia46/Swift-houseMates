//
//  NewProfileViewController.swift
//  TenantAppSwift
//
//  Created by Alix on 31/12/2015.
//  Copyright © 2015 TenantTeam. All rights reserved.
//

import UIKit

class NewProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let loggedUser = LoggedUser.sharedInstance
    
    var imagePicker = UIImagePickerController()

    // Info provided at Sign Up
    @IBOutlet weak var loggedUserName: UILabel!
    @IBOutlet weak var loggedFullName: UILabel!
    @IBOutlet weak var loggedEmail: UILabel!
    @IBOutlet weak var userPicture: UIImageView!
    
    // New Info
    @IBOutlet weak var targetedArea: UITextField!
    @IBOutlet weak var rentBand: UITextField!
    @IBOutlet weak var noticePeriod: UITextField!
    
    // Labels and buttons
    
    @IBOutlet weak var yoursearchLabel: UILabel!
    @IBOutlet weak var loadpictureLabel: UIButton!
    @IBOutlet weak var nextLabel: UIButton!
    
    
    @IBAction func photofromLibrary(sender: UIButton) {
        
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.modalPresentationStyle = .Popover
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        userPicture.contentMode = .ScaleAspectFit //3
        userPicture.image = chosenImage //4
        dismissViewControllerAnimated(true, completion: nil) //5
    }
    
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
        self.loggedFullName.text = "\(loggedUser.firstname) \(loggedUser.lastname)"
        self.loggedEmail.text = loggedUser.email
        imagePicker.delegate = self
        
        //Label and button colour background
        
        yoursearchLabel.backgroundColor = UIColor(hexString: "419bd2")
        loadpictureLabel.backgroundColor = UIColor(hexString: "419bd2")
        nextLabel.backgroundColor = UIColor(hexString: "419bd2")
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
        

    
    @IBAction func stepone(sender: UIButton) {
        let targetarea:NSString = targetedArea.text!
        let rentband: Int? = Int(rentBand.text!)
        let noticeperiod: Int? = Int(noticePeriod.text!)
        
        
        if ( targetarea.isEqualToString("") || (rentband == nil) || (noticeperiod == nil)) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Failed!"
            alertView.message = "Please enter complete search information"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
        } else {
            do {
                
                let postEndpoint: String = "https://housematey.herokuapp.com/users/\(loggedUser.id)"
                let url = NSURL(string: postEndpoint)!
                let session = NSURLSession.sharedSession()
                let putParams : [String: AnyObject] = ["currentArea": targetarea, "currentRentBand": rentband!, "currentNoticePeriodDays": noticeperiod!]
                
                
                // Create the request
                let request = NSMutableURLRequest(URL: url)
                request.HTTPMethod = "PUT"
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                do {
                    request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(putParams, options: NSJSONWritingOptions())
                    print(putParams)
                } catch {
                    print("bad things happened")
                }
                
                // Make the POST call and handle it in a completion handler
                session.dataTaskWithRequest(request, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                    // Make sure we get an OK response
                    guard let realResponse = response as? NSHTTPURLResponse where
                        realResponse.statusCode == 200 else {
                            print("Not a 200 response")
                            return
                    }
                    
                    // Read the JSON
                    
                    if let json = JSON(data: data!) as? JSON {
                        // Print what we got from the call
                        print("PUT: \(json)")
                        //                self.performSelectorOnMainThread("updatePostLabel:", withObject: postString, waitUntilDone: false)
                        //                    NSUserDefaults.standardUserDefaults().setObject(json["_id"].stringValue, forKey: "LoggedInUserId")
                    }
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        self.performSegueWithIdentifier("StepOneComplete", sender: self)
                    })
                    
                    
                }).resume()
            }
        }
    }
    
    
    
}

    

    