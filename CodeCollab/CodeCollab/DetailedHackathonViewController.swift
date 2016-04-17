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
    
    var ideatext : String?
    
    var groupnumber: String?
    
    var currentAmount: String?
    
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
    
   
    
    
    
    
    
    
    
    @IBAction func addIdea(sender: AnyObject) {
        
        showAlert1()

    }
    
    
    func showAlert1() {
        var alert = UIAlertController(title: "New Idea", message: "Enter your idea briefly. Don't be too specific, incase people try to copy you.", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            self.ideatext = textField.text!
            self.showAlert2()
        }))
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    func showAlert2() {
        var alert = UIAlertController(title: "How big is your team?", message: "Normal teams range from 3-6 members", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            self.groupnumber = textField.text!
            self.showAlert3()
        }))
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func showAlert3() {
        var alert = UIAlertController(title: "How many members do you have right now?", message: "Are you solo? With another person? (1,2, etc.)", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            self.currentAmount = textField.text!
            
            print(self.ideatext! + self.groupnumber! + self.currentAmount!)
            
        }))
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
    }

}
