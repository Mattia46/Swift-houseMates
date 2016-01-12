//
//  truncateService.swift
//  TenantAppSwift
//
//  Created by Alix on 06/01/2016.
//  Copyright © 2016 TenantTeam. All rights reserved.
//

import Foundation
import UIKit


extension String {
    /// Truncates the string to length number of characters and
    /// appends optional trailing string if longer
    func truncate(length: Int, trailing: String? = nil) -> String {
        if self.characters.count > length {
            return self.substringToIndex(self.startIndex.advancedBy(length)) + (trailing ?? "")
        } else {
            return self
        }
    }
}


