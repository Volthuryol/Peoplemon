//
//  MapViewController.swift
//  Peoplemon
//
//  Created by Caden Cheek on 11/9/16.
//  Copyright © 2016 Interapt. All rights reserved.
//

import UIKit
import MapKit
import MBProgressHUD
import CoreLocation

class MapViewController: UIViewController{

    @IBOutlet weak var mapView: MKMapView!


    let locationManager = CLLocationManager()
    var updateLocation = true
    var latitudeDelta = 0.005
    var longitudeDelta = 0.005
    var annotations: [MapPin] = []
    var overlay: MKOverlay?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        mapView.delegate = self
        //UserStore.shared.delegate = self //For timer
        locationManager.requestWhenInUseAuthorization() //pop up to request that the app can use user location
        locationManager.distanceFilter = kCLDistanceFilterNone //give me every movement
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //every time the distanceFilter gets a movement, get the best accuracy
        mapView.showsUserLocation = true //show the blue dot on the map to show where you are
        locationManager.startUpdatingLocation() //can turn on and turn off getting user location
        nearbyPeople()

        mapView.mapType = MKMapType.hybrid


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("view appeared")
        if !WebServices.shared.userAuthTokenExists() || WebServices.shared.userAuthTokenExpired(){
            performSegue(withIdentifier: "PresentLoginNoAnimation", sender: self)
            //print("I got here")
        }
    }

    func nearbyPeople() {
        let nearby  = People(radius: 99.00)
        WebServices.shared.getObjects(nearby) { (objects, errors) in
            if let objects = objects {
                let oldannotations = self.annotations
                self.annotations = []
                for user in objects {
                    let pin = MapPin(people: user)
                    self.annotations.append(pin)
                }
                self.mapView.addAnnotations(self.annotations)
                self.mapView.removeAnnotations(oldannotations)
            }

        }
    }
    //Mark - @IBActions



    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        UserStore.shared.logout{
            self.performSegue(withIdentifier: "PresentLogin", sender: self)
        }

    }

    @IBAction func checkIn(_ sender: UIBarButtonItem) {
        if let location = locationManager.location{



            //create user object with that location
            let person = People(longitude: location.coordinate.longitude, latitude: location.coordinate.latitude)

            //call webservices .post with the user object
            WebServices.shared.postObject(person, completion: { (person, error) in
                if let error = error {
                    self.present(Utils.createAlert(message: error), animated: true, completion: nil)
                }else{
                    self.present(Utils.createAlert("Awesome!", message: "You are Checked In 😀"),  animated: true, completion: nil)

                }

            })


        }

    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpanMake(latitudeDelta, longitudeDelta))
        mapView.setRegion(region, animated: true)
        updateLocation = false
        locationManager.stopUpdatingLocation()

    }

}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        let reuseId = "pin"

        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView?.isEnabled = true
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let mapPin = view.annotation as? MapPin, let people = mapPin.people, let name = people.userName, let userId = people.userId {
            let alert = UIAlertController(title: "Catch User", message: "Catch\(name)?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Catch", style: .default, handler: { (action) in
                let catchPeople = People(caughtUserId: userId, radius: Constants.radius)
                WebServices.shared.postObject(catchPeople, completion: { (object, error) in
                    if let error = error{
                        self.present(Utils.createAlert(message: error), animated: true, completion: nil)
                    } else{
                        self.present(Utils.createAlert("AWESOME!", message: "User Caught"), animated: true, completion: nil)
                    }
                })
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        self.overlay = overlay
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.green
        renderer.lineWidth = 5.0
        renderer.lineCap = CGLineCap.round
        return renderer
    }
}

