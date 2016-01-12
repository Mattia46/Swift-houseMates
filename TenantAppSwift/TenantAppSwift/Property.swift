//
//  Property.swift
//  TenantAppSwift
//
//  Created by Alix on 28/12/2015.
//  Copyright © 2015 TenantTeam. All rights reserved.
//

import Foundation


class Property {
    
    // MARK: Properties
    
    var id: String
    var post_code: String
    var street_name: String
    var property_type: String
    var contract_start: String
    var contract_end: String
    var monthly_cost: Int
    
    // MARK: Initialization
    
    init?(id: String, post_code: String, street_name: String, property_type: String, monthly_cost: Int, contract_start: String, contract_end: String) {
        // Initialize stored properties.
        self.id = id
        self.post_code = post_code
        self.street_name = street_name
        self.property_type = property_type
        self.contract_start = contract_start
        self.contract_end = contract_end
        self.monthly_cost = monthly_cost
        
    }
    
}