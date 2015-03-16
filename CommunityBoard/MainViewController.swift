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

class MainViewController: UIViewController, CLLocationManagerDelegate {
    
    var myRootRef = Firebase(url: "https://shining-heat-5935.firebaseio.com")
    var locationManager: CLLocationManager!
    
    @IBOutlet var mode_control: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mode_control.tintColor = UIColor(red: 211.0/255, green: 70.0/255, blue: 74.0/255, alpha: 1)
        mapView.hidden = true
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var userCoordinates: CLLocationCoordinate2D = manager.location.coordinate
        
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error) -> Void in
        
            if error != nil {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                
                var placemark = placemarks[0] as CLPlacemark
                    
                self.locationManager.stopUpdatingLocation()
                println(placemark.locality)
                println(placemark.administrativeArea)
            }
            else {
                println("Problem with the data from geocoder")
            }
        })
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        println("Error while updating location " + error.localizedDescription)
    }

}
