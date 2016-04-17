//
//  LoadingViewController.swift
//  NewsOTG
//
//  Created by Avinash Jain on 1/2/16.
//  Copyright © 2016 Avinash Jain. All rights reserved.
//

import UIKit
import Firebase


class LoadingViewController: UIViewController {

    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    let ref = Firebase(url: "https://codecollab1.firebaseio.com")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ref.unauth()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)


        // Do any additional setup after loading the view.
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
        activityIndicator.color = UIColor.whiteColor()
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: Selector("nextpage"), userInfo: nil, repeats: false)

    }
    
    func nextpage(){
        
        print("THis is working")
        
        if ref.authData != nil {
            // user authenticated
            print(ref.authData.uid)
            var baseref = Firebase(url: "https://punch-it.firebaseio.com/users/\(ref.authData.uid)")
            
            baseref.observeEventType(.Value, withBlock: { snapshot in
                
                
                
                var phone = snapshot.value["phone"]
                if phone != nil {
                    print(phone)
                    self.performSegueWithIdentifier("merch", sender: self) }
                else {
                    self.performSegueWithIdentifier("restaurant", sender: self) }
                
                
                }, withCancelBlock: { error in
                    print(error.description)
            })

            
            //performSegueWithIdentifier("restaurant", sender: self)
            print(ref.authData)
        } else {
            // No user is signed in
            performSegueWithIdentifier("signup", sender: self)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
