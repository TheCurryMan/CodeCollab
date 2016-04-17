//
//  DetailedHackathonViewController.swift
//  CodeCollab
//
//  Created by Avinash Jain on 4/16/16.
//  Copyright © 2016 Avinash Jain. All rights reserved.
//



import UIKit
import MapKit
import Firebase

class DetailedHackathonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var bgimg: UIImageView!
    
    @IBOutlet var mainimg: UIImageView!
    
    var ideatext : String?
    
    var groupnumber: String?
    
    var currentAmount: String?
    
    var name: String?
    
    var dataStr: NSString?
    
    @IBOutlet var mapView: MKMapView!
    
    
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
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
            mapView.delegate = self
        
        
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
            mapView.showsUserLocation = true
        
            getCoordinatePoints()
        
        
        //mapView.hidden = true
        
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
    
    var points: [Person] = []
    
    func getCoordinatePoints() {
        points.append(Person(coordinate: CLLocationCoordinate2D(latitude: 37.2941120, longitude: -122.0361800), title: "Raj Vermouth"))
        points.append(Person(coordinate: CLLocationCoordinate2D(latitude: 37.2982090, longitude: -122.0563500), title: "Bob Adams"))
        points.append(Person(coordinate: CLLocationCoordinate2D(latitude: 37.2638320, longitude: -122.0230150), title: "Peeta Bread"))
        points.append(Person(coordinate: CLLocationCoordinate2D(latitude: 37.2971120, longitude: -122.0341800), title: "John Jacob"))
        points.append(Person(coordinate: CLLocationCoordinate2D(latitude: 37.3922090, longitude: -122.0583500), title: "Elizabeth Warden"))
        points.append(Person(coordinate: CLLocationCoordinate2D(latitude: 37.4698320, longitude: -122.0239150), title: "Vishal Ramu"))
        points.append(Person(coordinate: CLLocationCoordinate2D(latitude: 38.2141120, longitude: -122.0361800), title: "Richard Head"))
        points.append(Person(coordinate: CLLocationCoordinate2D(latitude: 37.3912090, longitude: -122.2563500), title: "Mack Miller"))
        points.append(Person(coordinate: CLLocationCoordinate2D(latitude: 37.2138320, longitude: -122.0239150), title: "Dan Davy"))
        
        mapView.addAnnotations(points)
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let location = locations.last! as CLLocation
        var location2 = CLLocationCoordinate2D(latitude: 37.2941120, longitude: -122.0361800)
        var location3 = CLLocationCoordinate2D(latitude: 37.3382080, longitude: -121.8863290)
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        createAnnotation(location2, title: "", subtitle: "")
        
        self.mapView.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors : " + error.localizedDescription)
    }
    
    func createAnnotation(location: CLLocationCoordinate2D, title: String, subtitle: String) {
        var anotation = MKPointAnnotation()
        anotation.coordinate = location
        anotation.title = title
        anotation.subtitle = subtitle
        self.mapView.addAnnotation(anotation)
        
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
            cell.group.text = info[2] + "/" + info[3]}
        
        return cell
    }
    
    var button : UIButton?
    
//    button.type(UIButtonType.DetailDisclosure) as UIButton
    
    func mapView(mapView: MKMapView!,
        viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
            
            button = UIButton(type: UIButtonType.DetailDisclosure)
            button?.setTitle("Join", forState: UIControlState.Normal)
            
            if annotation is MKUserLocation {
                //return nil so map view draws "blue dot" for standard user location
                return nil
            }
            
            let reuseId = "pin"
            
            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.canShowCallout = true
                pinView!.animatesDrop = true
                pinView!.pinColor = .Purple
                pinView!.leftCalloutAccessoryView = button
            }
            else {
                pinView!.annotation = annotation
            }
            
            return pinView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let alertController = UIAlertController(title: "Would you like to join this carpool?", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil ))
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firebaseData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120.0
    }
    @IBOutlet var segmentedControl: UISegmentedControl!

    @IBAction func indexChanged(sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
           tableView.hidden = false
            mapView.hidden = true
        case 1:
            tableView.hidden = true
            mapView.hidden=false
        default: print("Nothing")
        }
        
    }
}
