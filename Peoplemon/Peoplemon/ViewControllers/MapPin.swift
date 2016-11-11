//
//  File.swift
//  Peoplemon
//
//  Created by Caden Cheek on 11/9/16.
//  Copyright © 2016 Interapt. All rights reserved.
//

import UIKit
import MapKit

class MapPin: NSObject, MKAnnotation {


    var coordinate: CLLocationCoordinate2D
    var userName: String?
    var userId: String?
    var title: String?
    var people: People?

    init(people: People ) {
        self.people = people
        self.userId = people.userId
        self.userName = people.userName


        if let lat = people.latitude, let long = people.longitude {
            self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        } else {
            self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
            
            
        }
    }
    
}
