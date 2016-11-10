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
    var userId: String?
    var avatarBase64: String?
    var title: String?
    var subtitle: String?
    var people: People?

    init(people: People ) {
        self.people = people
        self.userId = people.userId
        self.subtitle = people.userName
        self.title = people.userName
        self.avatarBase64 = people.avatarBase64

        if let lat = people.latitude, let long = people.longitude {
            self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        } else {
            self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
            
            
        }
    }
}
