//
//  TableViewCell.swift
//  CodeCollab
//
//  Created by Sara Subbanna on 4/16/16.
//  Copyright (c) 2016 Avinash Jain. All rights reserved.
//

import UIKit

class HackLeftTableViewCell: UITableViewCell {
    
    
    
    
    var title: String!
    var date: String!
    var address: String!
    
   
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellAddress: UILabel!
    @IBOutlet weak var cellDate: UILabel!
    @IBOutlet var button: UIButton!
    
    
    
    func loadItems (name: String, address: String, date: String, image: UIImage) {
        
               
        cellName.text = name
        cellAddress.text = address
        cellDate.text = date
        button.setBackgroundImage(image, forState: UIControlState.Normal)
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
