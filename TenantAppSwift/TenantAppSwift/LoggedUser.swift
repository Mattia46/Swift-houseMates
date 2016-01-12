//
//  LoggedUser.swift
//  TenantAppSwift
//
//  Created by Alix on 02/01/2016.
//  Copyright © 2016 TenantTeam. All rights reserved.
//

import Foundation

public class LoggedUser {
    
    public static let sharedInstance = LoggedUser()
    public var id: String = ""
    public var username: String = ""
    public var firstname: String = ""
    public var lastname: String = ""
    public var email: String = ""
    
    private init() {}
}
