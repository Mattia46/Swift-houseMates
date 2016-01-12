//
//  ProfileTableViewCell.swift
//  TenantAppSwift
//
//  Created by Alix on 28/12/2015.
//  Copyright © 2015 TenantTeam. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    
    
    @IBOutlet weak var streetnameLabel: UILabel!
    
    @IBOutlet weak var postcodeLabel: UILabel!
    
    @IBOutlet weak var propertytypeLabel: UILabel!
    
    @IBOutlet weak var monthlycostLabel: UILabel!
    
    @IBOutlet weak var startdateLabel: UILabel!
    
    @IBOutlet weak var enddateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
