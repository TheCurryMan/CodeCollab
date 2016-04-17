//
//  RideShareViewController.swift
//  HackPrep
//
//  Created by Sara Subbanna on 4/16/16.
//  Copyright (c) 2016 Srividhya Gopalan. All rights reserved.
//

import UIKit
import MapKit

class RideShareViewController: UIViewController {
 /*
    var profile: Member!
    var carpools: [Carpool] = []
    var members: [Member] = []
    var riders: [Rider] = []
    var organizer: Member = Member(profilePic: (UIImage(named: "image x") as UIImage?)!, location: CLLocationCoordinate2D(latitude: 37.3229980, longitude: -122.0321820), name: "Sara Subbanna", username: "zaneyris", password: "password", email: "sarasubbanna@gmail.com", phone: "4089362048")

    @IBOutlet weak var rideMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfile()
        getCarpools()
        let annotation = Rider(coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), name: "Person", profile: Member(profilePic: (UIImage(named: "image x") as UIImage?)!, location: CLLocationCoordinate2D(latitude: 37.3229980, longitude: -122.0321820), name: "Zaneyris Lockwood", username: "zaneyris", password: "password", email: "sarasubbanna@gmail.com", phone: "4089362048"))
        annotation.color = MKPinAnnotationColor.Green
        rideMap.addAnnotation(annotation)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func findRideButtonTapped(sender: AnyObject) {
        
        self.profile = (Member(profilePic: (UIImage(named: "image x") as UIImage?)!, location: CLLocationCoordinate2D(latitude: 37.2941120, longitude: -122.0361800), name: "Danny Summer", username: "zaneyris", password: "password", email: "sarasubbanna@gmail.com", phone: "4089362048"))
        
            var assignedDriver: Carpool!
            for driver in carpools {
                
                var smallestDistance: Double = 10000000000000000000000000
                if rideDistance(profile.location, end: driver.coordinate) < smallestDistance && driver.currentRiders.count < driver.maxRiders {
                    assignedDriver = driver
                    rideDistance(profile.location, end: driver.coordinate)
                }
            }
        self.profile = (Member(profilePic: (UIImage(named: "image x") as UIImage?)!, location: CLLocationCoordinate2D(latitude: 37.2941120, longitude: -122.0361800), name: "Funny Bone", username: "zaneyris", password: "password", email: "sarasubbanna@gmail.com", phone: "4089362048"))
            assignedDriver.currentRiders.append(profile)
        let alertController = UIAlertController(title: assignedDriver.name, message: "You have found a carpool with \(assignedDriver.name)", preferredStyle:UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel)
            { action -> Void in
                // Put your code here
            })
        alertController.addAction(UIAlertAction(title: "Learn More", style: UIAlertActionStyle.Default)
            { action -> Void in
                self.performSegueWithIdentifier("see carpool", sender: self)
            })
        self.presentViewController(alertController, animated: true, completion: nil)

        
    }
    
    
    func getProfile() {
        members.append((Member(profilePic: (UIImage(named: "image x") as UIImage?)!, location: CLLocationCoordinate2D(latitude: 37.2941120, longitude: -122.0361800), name: "Purple Flamingo", username: "zaneyris", password: "password", email: "sarasubbanna@gmail.com", phone: "4089362048")))
       members.append(Member(profilePic: (UIImage(named: "image x") as UIImage?)!, location: CLLocationCoordinate2D(latitude: 37.3382080, longitude: -121.8863290), name: "Donny Jack", username: "zaneyris", password: "password", email: "sarasubbanna@gmail.com", phone: "4089362048"))
        members.append(Member(profilePic: (UIImage(named: "image x") as UIImage?)!, location: CLLocationCoordinate2D(latitude: 37.4613270, longitude: -122.1977430), name: "John Jacob", username: "zaneyris", password: "password", email: "sarasubbanna@gmail.com", phone: "4089362048"))
        members.append(Member(profilePic: (UIImage(named: "image x") as UIImage?)!, location: CLLocationCoordinate2D(latitude: 37.4613270, longitude: -122.1977430), name: "Snoop Dogg", username: "zaneyris", password: "password", email: "sarasubbanna@gmail.com", phone: "4089362048"))
        members.append(Member(profilePic: (UIImage(named: "image x") as UIImage?)!, location: CLLocationCoordinate2D(latitude: 37.3382080, longitude: -121.8863290), name: "Ruiz Martinez", username: "zaneyris", password: "password", email: "sarasubbanna@gmail.com", phone: "4089362048"))
         members.append(Member(profilePic: (UIImage(named: "image x") as UIImage?)!, location: CLLocationCoordinate2D(latitude: 37.3227200, longitude: -122.0580170), name: "Elliot Tiham", username: "zaneyris", password: "password", email: "sarasubbanna@gmail.com", phone: "4089362048"))
        members.append(Member(profilePic: (UIImage(named: "image x") as UIImage?)!, location: CLLocationCoordinate2D(latitude: 37.3033510, longitude: -122.0013360), name: "Eric Razon", username: "zaneyris", password: "password", email: "sarasubbanna@gmail.com", phone: "4089362048"))
        members.append(Member(profilePic: (UIImage(named: "image x") as UIImage?)!, location: CLLocationCoordinate2D(latitude: 37.3229980, longitude: -122.0321820), name: "Adam Smith", username: "zaneyris", password: "password", email: "sarasubbanna@gmail.com", phone: "4089362048"))
        
        
        for obj in members {
            riders.append(Rider(coordinate: obj.location, name: "Person", profile: obj))
        }
        for ride in riders {
            rideMap.addAnnotation(ride)
        }
    }
    
    func getCarpools() {
        carpools.append(Carpool(coordinate: CLLocationCoordinate2D(latitude: 37.2638320, longitude: -122.0230150), name: "Vignesh Kumar", maxRiders: 4, currentRiders: []))
        organizer = Member(profilePic: (UIImage(named: "image x") as UIImage?)!, location: CLLocationCoordinate2D(latitude: 37.3229980, longitude: -122.0321820), name: "Sara Subbanna", username: "zaneyris", password: "password", email: "sarasubbanna@gmail.com", phone: "4089362048")
        rideMap.addAnnotations(carpools)
    }
    
    func rideDistance(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D)->Double {
        var x1 = Double(start.latitude )
        var y1 = Double(start.longitude )
        var x2 = Double(end.latitude )
        var y2 = Double(end.longitude )
        
        var x3 = (x1 + x2)*(x1 + x2)
        var y3 = (y1 + y1)*(y1 + y2)
        var difference = sqrt(x3 + y3)
        return difference
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "see carpool") {
            //backgroundMusic.stop()
            var svc = segue.destinationViewController as! CarpoolViewController;
            svc.organizer = self.organizer
            svc.members = self.members
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
*/

}
