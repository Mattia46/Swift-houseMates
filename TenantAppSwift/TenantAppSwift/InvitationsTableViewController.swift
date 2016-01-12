//
//  InvitationsTableViewController.swift
//  TenantAppSwift
//
//  Created by Alix on 06/01/2016.
//  Copyright © 2016 TenantTeam. All rights reserved.
//

import UIKit

class InvitationsTableViewController: UITableViewController {

    let loggedUser = LoggedUser.sharedInstance
    
    var invitations = [User]()
    var lbl_header = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation bar formatting
        
        let logo = UIImage(named: "logo2")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "419bd2")
        
        //Background colour
        
        self.view.backgroundColor = UIColor(hexString: "cbcbcc")
        
        loadSampleUserInvitations(loggedUser.id)

    }
    
    func loadSampleUserInvitations(userId: String) {
        
        
        
        let path = "https://housematey.herokuapp.com/user_inv_list/\(userId)"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            let json = JSON(data: data!)
            
            
            for object in json.arrayValue {
                
                
                let userInvId = object["_id"].stringValue
                let userInvUsername = object["username"].stringValue
                let userInvFirstname = object["firstName"].stringValue
                let userInvLastname = object["lastName"].stringValue
                let userInvTargetArea = object["currentArea"].stringValue
                let userInvTargetRent = object["currentRentBand"].intValue
                
                let userInvitation = User(id: userInvId, username: userInvUsername, firstname: userInvFirstname, lastname: userInvLastname,targetArea: userInvTargetArea, targetRent: userInvTargetRent)!
                
                
                self.invitations.append(userInvitation)
                print(self.invitations[0].targetArea)
                
            }
            
            dispatch_async(dispatch_get_main_queue(),{
                self.tableView.reloadData()
            })
        }
        
        task.resume()
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return invitations.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "InvitationsCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! InvitationsTableViewCell

        let invitation = invitations[indexPath.row]
        cell.fullnameLabel.text = "\(invitation.firstname) \(invitation.lastname)"
        cell.targetareaLabel.text = invitation.targetArea
        cell.sharedButton.tag = indexPath.row
        cell.sharedButton.addTarget(self, action: "acceptInvitation:", forControlEvents: .TouchUpInside)
        

        return cell
    }
   
    override func tableView(tableView: UITableView, viewForHeaderInSection  section: Int) -> UIView?
    {
        self.lbl_header.frame = CGRectMake(20, 20, self.view.frame.size.width, 150)
        self.lbl_header.text = "My invitations to connect"
        self.lbl_header.backgroundColor = UIColor(hexString: "419bd2")
        self.lbl_header.textColor = UIColor.whiteColor()
        self.lbl_header.textAlignment = NSTextAlignment.Center
        return self.lbl_header
        
    }
    
    @IBAction func acceptInvitation(sender: UIButton) {
        print(sender.tag)
        print("Hello World")
        print(self.invitations[sender.tag].id)
        createConnection(self.invitations[sender.tag].id)
    }
    
    func createConnection(user1Id: String) {
        
        let session = NSURLSession.sharedSession()
        let newConnectionPut: NSString = user1Id
        let path: String = "https://housematey.herokuapp.com/user_connection/\(user1Id)/\(loggedUser.id)"
        let url = NSMutableURLRequest(URL: NSURL(string: path)!)
        print(url)
        url.HTTPMethod = "PUT"
        
        // set new post as HTTPBody for request
//        url.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        do {
//            url.HTTPBody = try NSJSONSerialization.dataWithJSONObject(newConnectionPut, options: NSJSONWritingOptions())
//            print(newConnectionPut)
//            
//        } catch {
//            print("bad things happened")
//        }
        
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
