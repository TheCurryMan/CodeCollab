//
//  ViewController.swift
//  Test
//
//  Created by Sara Subbanna on 4/16/16.
//  Copyright (c) 2016 Srividhya Gopalan. All rights reserved.
//

import UIKit
import MapKit



class HackathonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var hackathons: [Hackathon] = []
    
    var chosenHackathon : Hackathon?
    
    var hackathonData = [[""]]
    
    var chosenIndex = 0
    
    @IBOutlet weak var leftTable: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        //viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationItem.setHidesBackButton(false, animated: false)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftTable.delegate = self
        leftTable.dataSource = self
        
        var url = NSURL(string: "http://dogwood-flames-128319.appspot.com/mlh")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            
   
            
            let urlError = false
            
            if error == nil {
                
                var finalData: Array = [[""]]
                
                let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!
                
                var hacks = urlContent.componentsSeparatedByString("|")
                for i in hacks{
                    var arr = i.componentsSeparatedByString(",")
                    if arr[0] == "" {
                        arr.removeFirst()
                    }
                    finalData.append(arr)
                    
                }
                
                finalData.removeAtIndex(0)
                finalData.removeLast()
                
                self.hackathonData = finalData
                
                self.getHackathons()
                
                
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if urlError == true {
                        
                        print("error")
                        
                    } else {
                        print("done with async")
                        self.leftTable.reloadData()
                        
                    }}}})
        
        task.resume()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getHackathons() {
        if self.hackathonData.count < 2 {
            print("data hasn't come yet")
        }
        
        else {
        
            for j in 0...6{
                
                var i = hackathonData[j]
            
                        
                        print(i)
                        
                        var text = i[2]
                        var text2 = i[1]
            
                        var url = NSURL(string: String(text.characters.dropFirst()))
                        var url2 = NSURL(string: String(text2.characters.dropFirst()))
                        var data:NSData?
                        var image:UIImage?
                        var data2:NSData?
                        var image2:UIImage?
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                data = NSData(contentsOfURL: url!)
                                image = UIImage(data:data!)
                                
                                data2 = NSData(contentsOfURL: url2!)
                                image2 = UIImage(data:data2!)
                                self.hackathons.append(Hackathon(name: i[3], image: image!, date: i[4], blurb: "", location: CLLocationCoordinate2D(), teamSize: 4, prizes: [], members: [], address: i[5] + ", " + i[6], bgimg: image2!))
                                

                                })
                        })
                        
                        
            
                        
                        
                        
            }
            
             
        }
        print("Ended")
        
        leftTable.reloadData()
       
           
    }
    
        
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return hackathonData.count
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.selectedCell = indexPath.row
        //self.performSegueWithIdentifier("To Deep Look", sender: self)
        chosenIndex = indexPath.row
        chosenHackathon = hackathons[indexPath.row]
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("detail", sender: self)
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Left Cells", forIndexPath: indexPath) as! HackLeftTableViewCell
        
        if hackathonData.count < 4 {
            print("Data coming")
        }
        else {
        var row = indexPath.row
            
            
        var dateString = (hackathons[row].date)
        cell.loadItems(hackathons[row].name, address: hackathons[row].address, date: dateString, image: hackathons[row].image)
        
        }
        // Configure the cell...
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detail" {
            var vc : DetailedHackathonViewController = segue.destinationViewController as! DetailedHackathonViewController
            
            vc.hackathonIndex = chosenIndex
            vc.hackathon = chosenHackathon
        }
    }
    
    
    
    
    
    
    
}

