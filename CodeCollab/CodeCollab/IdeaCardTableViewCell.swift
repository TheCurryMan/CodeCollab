//
//  IdeaCardTableViewCell.swift
//  CodeCollab
//
//  Created by Avinash Jain on 4/16/16.
//  Copyright © 2016 Avinash Jain. All rights reserved.
//

import UIKit

class IdeaCardTableViewCell: UITableViewCell {

    @IBOutlet var profile: UIImageView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var idea: UILabel!
    
    @IBAction func join(sender: AnyObject) {
        
        
    }
    
    @IBOutlet var group: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
