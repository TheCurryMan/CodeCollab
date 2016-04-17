//
//  SignUpViewController.swift
//  NewsOTG
//
//  Created by Avinash Jain on 12/1/15.
//  Copyright © 2015 Avinash Jain. All rights reserved.
//



import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var email: UITextField!
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    @IBOutlet var signup: UIButton!
    
    @IBOutlet var fbsignup: UIButton!
    
    @IBOutlet var googsignup: UIButton!
    
    var ref = Firebase(url:"https://codecollab1.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signup.layer.cornerRadius = 10.0
        fbsignup.layer.cornerRadius = 10.0
        googsignup.layer.cornerRadius = 10.0
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func signUp(sender: UIButton) {
        
        var em = email.text
        var us = username.text
        var pass = password.text
        
        if em != "" && us != "" && pass != "" {
            
            ref.createUser(em, password: pass) { (error:NSError!) -> Void in
                if (error != nil){
                    print(error.localizedDescription)
                    
                } else{
                    print("New user created")
                    
                    self.ref.authUser(em, password: pass) {
                        error, authData in
                        if error != nil {
                            // an error occured while attempting login
                            print("Error in logging in")
                        } else {
                            // user is logged in, check authData for data
                            print(authData)
                            
                            let newUser = ["provider": authData.provider, "username": us]
                            
                            self.ref.childByAppendingPath("users").childByAppendingPath(authData.uid).setValue(newUser)
                            
                            self.performSegueWithIdentifier("homescreen", sender: self)
                        }
                    }
                    
                }
            }
        }
        
    }
    
    @IBAction func fbLogin(sender: AnyObject) {
        
        let ref = Firebase(url: "https://codecollab1.firebaseio.com")
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logOut()
        facebookLogin.logInWithReadPermissions(["email"], handler: {
            (facebookResult, facebookError) -> Void in
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
            } else if facebookResult.isCancelled {
                print("Facebook login was cancelled.")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                ref.authWithOAuthProvider("facebook", token: accessToken,
                    withCompletionBlock: { error, authData in
                        if error != nil {
                            print("Login failed. \(error)")
                        } else {
                            print("Logged in! \(authData)")
                            
                            let newUser = ["provider": authData.provider]
                            
                            self.ref.childByAppendingPath("users").childByAppendingPath(authData.uid).setValue(newUser)
                            
                            self.performSegueWithIdentifier("homescreen", sender: self)
                        }
                })
            }
        })
        
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
