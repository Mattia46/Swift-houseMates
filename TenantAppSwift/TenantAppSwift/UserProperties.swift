//
//  UserProperties.swift
//  TenantAppSwift
//
//  Created by Alix on 03/01/2016.
//  Copyright © 2016 TenantTeam. All rights reserved.
//


import Foundation

public class UserProperties {
    
    public static let sharedInstance = UserProperties()
    public var props: [String] = []
    
    private init() {}
}
