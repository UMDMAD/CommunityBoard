//
//  AddViewController.swift
//  CommunityBoard
//
//  Created by Kieran Raftery on 3/28/15.
//  Copyright (c) 2015 MAD. All rights reserved.
//

import UIKit
import CoreLocation

class AddViewController: UIViewController {
    
    let myRootRef = Firebase(url: "https://shining-heat-5935.firebaseio.com/Communities")
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBAction func submitPressed(sender: AnyObject) {
        
        let address = addressField.text + " " + cityField.text + ", " + stateField.text
        let community = cityField.text + ", " + stateField.text
        
        CLGeocoder().geocodeAddressString(address, completionHandler: {(placemarks, error)->Void in
            if error == nil {
                
                let placemark = placemarks[0] as CLPlacemark
                let longitude = placemark.location.coordinate.longitude
                let latitude = placemark.location.coordinate.latitude
                
                let data = ["Name": self.titleField.text, "Address": self.addressField.text, "Description": self.descriptionField.text, "longitude": longitude, "latitude": latitude]
                
                self.myRootRef.childByAppendingPath(community).childByAppendingPath(self.titleField.text).setValue(data)
                
                self.navigationController?.popViewControllerAnimated(true)
            }
        })
    }
}