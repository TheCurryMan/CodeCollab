//
//  DetailedHackathonViewController.swift
//  CodeCollab
//
//  Created by Avinash Jain on 4/16/16.
//  Copyright © 2016 Avinash Jain. All rights reserved.
//



import UIKit
import Firebase

class DetailedHackathonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var bgimg: UIImageView!
    
    @IBOutlet var mainimg: UIImageView!
    
    var ideatext : String?
    
    var groupnumber: String?
    
    var currentAmount: String?
    
    var name: String?
    
    var dataStr: NSString?
    
    @IBAction func controlbutton(sender: AnyObject) {
        
        
    }
    
    var firebaseData = [[String]]()
    var hackathonIndex : Int?
    
    var hackathon : Hackathon?
    
    var ref = Firebase(url:"https://codecollab1.firebaseio.com/")
    
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        var nib = UINib(nibName: "IdeaCardTableViewCell", bundle: nil)
        
        tableView.registerNib(nib, forCellReuseIdentifier: "custom")

        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = true
        self.navigationController!.view.backgroundColor = UIColor.clearColor()
        
        bgimg.image = hackathon?.bgimage
        mainimg.image = hackathon?.image
        
        var ideaRef = ref.childByAppendingPath(hackathon!.name)
        
        ideaRef.observeEventType(.Value, withBlock: { snapshot in
            
            var data = snapshot.value.objectForKey("Ideas") as! NSString
            
            self.dataStr = data
            
            var info = data.componentsSeparatedByString("|")
            
            
            
            for i in info {
                var item = i.componentsSeparatedByString(",")
                self.firebaseData.append(item)
                
            }
            print(self.firebaseData)
            self.tableView.reloadData()
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        tableView.reloadData()

        
    }
    
   
    
    
    
    
    
    
    
    @IBAction func addIdea(sender: AnyObject) {
        
        showAlert0()

    }
    
    func showAlert0() {
        var alert = UIAlertController(title: "New Idea", message: "What's your name?", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            self.name = textField.text!
            self.showAlert1()
        }))
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
        
        
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
            
            var hackRef = self.ref.childByAppendingPath(self.hackathon!.name)
            hackRef.updateChildValues(["Ideas":String(self.dataStr) + "|" + "\(self.name!),\(self.ideatext!),\(self.currentAmount!),\(self.groupnumber!)"])
            
        }))
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:IdeaCardTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("custom") as! IdeaCardTableViewCell
        
        if firebaseData.count > 1 {
        var info = firebaseData[indexPath.row]
        cell.name.text = info[0]
        cell.idea.text = info[1]
            cell.group.text = info[2] + "/" + info[3] + "Members" }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firebaseData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120.0
    }

}
