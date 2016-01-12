//
//  ConnectionsTableViewCell.swift
//  TenantAppSwift
//
//  Created by Alix on 04/01/2016.
//  Copyright © 2016 TenantTeam. All rights reserved.
//

import UIKit

class ConnectionsTableViewCell: UITableViewCell {
    

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var targetareaLabel: UILabel!
    
    @IBOutlet weak var targetrentLabel: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
