//
//  PostPinAnnotation.swift
//  CommunityBoard
//
//  Created by Kieran Raftery on 4/13/15.
//  Copyright (c) 2015 MAD. All rights reserved.
//

import Foundation
import MapKit

class PostPinAnnotation : NSObject, MKAnnotation {
    private var coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return coord
        }
    }
    
    var post: NSDictionary!
    var title: String!
    
    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        self.coord = newCoordinate
    }
}