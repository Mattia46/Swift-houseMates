//
//  InvitationsTableViewCell.swift
//  TenantAppSwift
//
//  Created by Alix on 06/01/2016.
//  Copyright © 2016 TenantTeam. All rights reserved.
//

import UIKit

class InvitationsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var fullnameLabel: UILabel!
    
    @IBOutlet weak var targetareaLabel: UILabel!
    
    @IBOutlet weak var sharedButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
