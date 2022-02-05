//
//  AssignmentCell.swift
//  Dividio
//
//  Created by Caio Teodoro on 30/01/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import UIKit

class AssignmentCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
        
        if self.isSelected == true {
            self.accessoryType = .checkmark
        } else {
            self.accessoryType = .none
        }
    }

}
