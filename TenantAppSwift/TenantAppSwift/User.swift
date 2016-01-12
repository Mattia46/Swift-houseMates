//
//  User.swift
//  TenantAppSwift
//
//  Created by Alix on 29/12/2015.
//  Copyright © 2015 TenantTeam. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    // MARK: Properties
    
    var id: String
    var username: String
    var firstname: String
    var lastname: String
    var photo = UIImage(named: "profile1")!
    var targetArea: String
    var targetRent: Int
    
    // MARK: Initialization
    
    init?(id: String, username: String, firstname: String, lastname: String, targetArea: String, targetRent: Int) {
        // Initialize stored properties.
        self.id = id
        self.username = username
        self.firstname = firstname
        self.lastname = lastname
        self.targetArea = targetArea
        self.targetRent = targetRent
        
    }
    
}