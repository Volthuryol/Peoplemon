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
    let latitudeDelta = 0.005
    let longitudeDelta = 0.005
    var updateLocation = true

    var annotations: [MapPin] = []
    var overlay: MKOverlay?
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        mapView.delegate = self
        locationManager.delegate = self
        UserStore.shared.delegate = self

        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        locationManager.startUpdatingLocation()

        loadMap()
    }

    override func viewDidAppear(_ animated: Bool) {
        if !WebServices.shared.userAuthTokenExists() || WebServices.shared.userAuthTokenExpired() {
            performSegue(withIdentifier: "PresentLoginNoAnimation", sender: self)
        } else {
            let userInfo = User()
            WebServices.shared.getObject(userInfo, completion: { (user, error) in
                if let user = user {
                    UserStore.shared.user = user
                }
            })
        }
        mapView.mapType = MKMapType.hybrid
    }
    func loadMap() {
        if let coordinate = locationManager.location?.coordinate {
            let checkIn = People(coordinate: coordinate)
            WebServices.shared.postObject(checkIn, completion: { (object, error) in

            })
        }

        let nearby = People(radius: Constants.radius)
        WebServices.shared.getObjects(nearby) { (objects, error) in
            if let objects = objects {
                let oldAnnotations = self.annotations
                self.annotations = []
                for people in objects {
                    let pin = MapPin(people: people)
                    self.annotations.append(pin)
                }
                self.mapView.addAnnotations(self.annotations)
                self.mapView.removeAnnotations(oldAnnotations)
            }
        }
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(loadMap), userInfo: nil, repeats: true)
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    //Mark - @IBActions



    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        UserStore.shared.logout{
            self.performSegue(withIdentifier: "PresentLogin", sender: self)
        }

    }
    /*
     @IBAction func checkIn(_ sender: UIBarButtonItem) {
     if let location = locationManager.location{



     //create user object with that location
     let person = People(coordinate: coordinate)

     //call webservices .post with the user object
     WebServices.shared.postObject(person, completion: { (person, error) in
     if let error = error {
     self.present(Utils.createAlert(message: error), animated: true, completion: nil)
     }else{
     self.present(Utils.createAlert("Awesome!", message: "You are Checked In 😀"),  animated: true, completion: nil)

     }

     })


     }

     } */
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpanMake(latitudeDelta, longitudeDelta))
        mapView.setRegion(region, animated: true)
        updateLocation = true

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
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = false
            pinView?.animatesDrop = false
        } else {
            pinView?.annotation = annotation
        }

        return pinView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let mapPin = view.annotation as? MapPin, let people = mapPin.people, let name = people.userName, let userId = people.userId {
            let alert = UIAlertController(title: "Catch User", message: "Catch \(name)?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Catch", style: .default, handler: { (action) in
                let catchPeople = People(userId: userId, radius: Constants.radius)
                WebServices.shared.postObject(catchPeople, completion: { (object, error) in
                    if let error = error {
                        self.present(Utils.createAlert(message: error), animated: true, completion: nil)
                    } else {
                        self.present(Utils.createAlert("Good job!", message: "User Caught"), animated: true, completion: nil)
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
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        renderer.lineCap = CGLineCap.round
        return renderer
    }
}

// MARK: - UserStoreDelegate
extension MapViewController: UserStoreDelegate {
    func userLoggedIn() {
        NotificationCenter.default.addObserver(self, selector: #selector(stopTimer), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(startTimer), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        stopTimer()
        startTimer()
    }
}

