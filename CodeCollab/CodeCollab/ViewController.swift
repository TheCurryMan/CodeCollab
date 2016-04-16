//
//  ViewController.swift
//  CodeCollab
//
//  Created by Avinash Jain on 4/16/16.
//  Copyright © 2016 Avinash Jain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var hackathonData = [] 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var url = NSURL(fileURLWithPath:"dogwood-flames-128319.appspot.com/mlh")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            
            print(data)
            
            let urlError = false
            
            if error == nil {
                
                let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!

                self.hackathonData = urlContent as! NSArray
                print(self.hackathonData)
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if urlError == true {
                        
                        print("error")
                        
                    } else {
                        
                        
                        
                        
                        
                    }}}})
        
        task.resume()}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

