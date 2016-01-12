//
//  ConnectionsTableViewController.swift
//  TenantAppSwift
//
//  Created by Alix on 04/01/2016.
//  Copyright © 2016 TenantTeam. All rights reserved.
//

import UIKit
import Foundation

class ConnectionsTableViewController: UITableViewController {

    let loggedUser = LoggedUser.sharedInstance
    
    var connections = [User]()
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
        
    loadSampleUserConnections(loggedUser.id)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadSampleUserConnections(userId: String) {
        
        
        
        let path = "https://housematey.herokuapp.com/user_con_list/\(userId)"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            let json = JSON(data: data!)
            
            
            for object in json.arrayValue {
                
                
                let userConId = object["_id"].stringValue
                let userConUsername = object["username"].stringValue
                let userConFirstname = object["firstName"].stringValue
                let userConLastname = object["lastName"].stringValue
                let userConTargetArea = object["currentArea"].stringValue
                let userConTargetRent = object["currentRentBand"].intValue
                
                let userConnection = User(id: userConId, username: userConUsername, firstname: userConFirstname, lastname: userConLastname,targetArea: userConTargetArea, targetRent: userConTargetRent)!
            
                
                self.connections.append(userConnection)
                print(self.connections[0].targetArea)
                
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
        return connections.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let NewcellIdentifier = "ConnectionsTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(NewcellIdentifier, forIndexPath: indexPath) as! ConnectionsTableViewCell

        let connection = connections[indexPath.row]
        
        cell.usernameLabel.text = connection.username
        cell.targetareaLabel.text = "Targeted area: \(connection.targetArea)"
        cell.targetrentLabel.text = "Budget(£): \(String(connection.targetRent))"

        return cell
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection  section: Int) -> UIView?
    {
        self.lbl_header.frame = CGRectMake(20, 20, self.view.frame.size.width, 150)
        self.lbl_header.text = "My connections"
        self.lbl_header.backgroundColor = UIColor(hexString: "419bd2")
        self.lbl_header.textColor = UIColor.whiteColor()
        self.lbl_header.textAlignment = NSTextAlignment.Center
        return self.lbl_header
        
    }
    

}
