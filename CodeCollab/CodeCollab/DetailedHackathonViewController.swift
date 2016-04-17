//
//  DetailedHackathonViewController.swift
//  CodeCollab
//
//  Created by Avinash Jain on 4/16/16.
//  Copyright © 2016 Avinash Jain. All rights reserved.
//

import UIKit

class DetailedHackathonViewController: UIViewController {

    @IBOutlet var bgimg: UIImageView!
    
    @IBOutlet var mainimg: UIImageView!
    
    @IBAction func controlbutton(sender: AnyObject) {
        
        
    }
    var hackathonIndex : Int?
    
    var hackathon : Hackathon?
    
    @IBOutlet var tableView: UITableView!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nib = UINib(nibName: "IdeaCardTableViewCell", bundle: nil)
        
        tableView.registerNib(nib, forCellReuseIdentifier: "custom")

        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = true
        self.navigationController!.view.backgroundColor = UIColor.clearColor()
        
        bgimg.image = hackathon?.bgimage
        mainimg.image = hackathon?.image
        
    }

}
