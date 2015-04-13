//
//  MapViewController.swift
//  CommunityBoard
//
//  Created by David LoBosco on 2/11/15.
//  Copyright (c) 2015 MAD. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var myRootRef = Firebase(url: "https://shining-heat-5935.firebaseio.com/Communities")
    var locationManager: CLLocationManager!
    var posts: NSDictionary!
    var postsKeys: NSArray!
    
    @IBOutlet var mode_control: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mode_control.tintColor = UIColor(red: 211.0/255, green: 70.0/255, blue: 74.0/255, alpha: 1)
        mapView.hidden = true
        mapView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 119
        postsKeys = []
        
        let nib = UINib(nibName: "vwCustomCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    /* Set the data of the tableview and mapview */
    func setData() {
        
        //tableview
        postsKeys = posts.allKeys
        tableView.reloadData()
        tableView.setNeedsDisplay()
        
        //mapview 
        for (key, value) in posts {
            let pin = PostPinAnnotation()
            pin.setCoordinate(CLLocationCoordinate2DMake(value.objectForKey("latitude") as Double, value.objectForKey("longitude") as Double))
            pin.title = value.objectForKey("Name") as String
            pin.post = value as NSDictionary;
            mapView.addAnnotation(pin)
        }
    }
    
    /* MARK - UITableViewDelegate methods */
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 119
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        let post = posts.valueForKey(postsKeys[indexPath.row] as String) as NSDictionary
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let postViewController = storyboard.instantiateViewControllerWithIdentifier("PostViewController") as PostViewController
        
        postViewController.titleText = post.objectForKey("Name") as String
        postViewController.addressText = post.objectForKey("Address") as String
        postViewController.cityText = post.objectForKey("City") as String
        postViewController.stateText = post.objectForKey("State") as String
        postViewController.descriptionText = post.objectForKey("Description") as String
        
        self.navigationController?.pushViewController(postViewController, animated: true)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
    /* MARK - UITableViewDataSource methods */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as CustomTableViewCell
        let post = posts.valueForKey(postsKeys[indexPath.row] as String) as NSDictionary
        cell.titleLabel.text = post.objectForKey("Name") as? String
        cell.descriptionTextView.text = post.objectForKey("Description") as? String
        cell.descriptionTextView.font = UIFont.systemFontOfSize(16)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postsKeys.count
    }
    
    
    /* MARK - CLLocationManagerDelegate */
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        self.locationManager.stopUpdatingLocation()
        
        let userCoordinates: CLLocationCoordinate2D = manager.location.coordinate
        let region = MKCoordinateRegion(center: userCoordinates, span: MKCoordinateSpanMake(0.05, 0.05))
        mapView.setRegion(region, animated: true)
        
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error) -> Void in
            
            if error != nil {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                
                let placemark = placemarks[0] as CLPlacemark
                
                let community = placemark.locality + ", " + placemark.administrativeArea
                self.myRootRef.childByAppendingPath(community).observeSingleEventOfType(.Value, withBlock: { snapshot in
                    self.posts = snapshot.value as NSDictionary
                    self.setData()
                })
            }
            else {
                println("Problem with the data from geocoder")
            }
        })
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        println("Error while updating location " + error.localizedDescription)
    }
    
    /* MARK - MKMapViewDelegate */
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if annotation is PostPinAnnotation {
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            
            pinAnnotationView.canShowCallout = true
            pinAnnotationView.animatesDrop = true
            
            let infoButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
            
            pinAnnotationView.rightCalloutAccessoryView = infoButton
            
            return pinAnnotationView
        }
        
        return nil
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        
        if let annotation = view.annotation as? PostPinAnnotation {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let postViewController = storyboard.instantiateViewControllerWithIdentifier("PostViewController") as PostViewController
            
            postViewController.titleText = annotation.post.objectForKey("Name") as String
            postViewController.addressText = annotation.post.objectForKey("Address") as String
            postViewController.cityText = annotation.post.objectForKey("City") as String
            postViewController.stateText = annotation.post.objectForKey("State") as String
            postViewController.descriptionText = annotation.post.objectForKey("Description") as String
            
            self.navigationController?.pushViewController(postViewController, animated: true)
        }
    }

   
    /* MARK - IBActions */
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        
        if mode_control.selectedSegmentIndex == 0 {
            tableView.hidden = false
            mapView.hidden = true
        }
        else {
            tableView.hidden = true
            mapView.hidden = false
        }
    }
    
    @IBAction func searchButtonClicked(sender: AnyObject) {
        
        var inputTextField: UITextField?
        let searchPrompt = UIAlertController(title: "Search", message: "Search posts in another community", preferredStyle: UIAlertControllerStyle.Alert)
        
        searchPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        searchPrompt.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            
            let community = inputTextField!.text
            CLGeocoder().geocodeAddressString(community, completionHandler: {(placemarks, error)->Void in
                if error == nil {
                    
                    let placemark = placemarks[0] as CLPlacemark
                    let region = MKCoordinateRegion(center: placemark.location.coordinate, span: MKCoordinateSpanMake(0.05, 0.05))
                    self.mapView.setRegion(region, animated: true)
                    
                    self.myRootRef.childByAppendingPath(community).observeSingleEventOfType(.Value, withBlock: { snapshot in
                        self.posts = snapshot.value as NSDictionary
                        self.setData()
                    })
                }
            })
        }))
        
        searchPrompt.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Community"
            inputTextField = textField
        })
        
        presentViewController(searchPrompt, animated: true, completion: nil)
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
