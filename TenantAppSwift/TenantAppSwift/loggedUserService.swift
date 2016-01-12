//
//  loggedUserService.swift
//  TenantAppSwift
//
//  Created by Alix on 03/01/2016.
//  Copyright © 2016 TenantTeam. All rights reserved.
//

import Foundation

class loggedUserService {
    
    func setLoggedUserId(json: JSON) {
        
        let loggedUser = LoggedUser.sharedInstance
        
        loggedUser.id = json["_id"].stringValue
        loggedUser.username = json["username"].stringValue
        loggedUser.firstname = json["firstName"].stringValue
        loggedUser.lastname = json["lastName"].stringValue
        loggedUser.email = json["email"].stringValue
        
        
    }
}