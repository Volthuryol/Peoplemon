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

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!


    let locationManager = CLLocationManager()
    var updateLocation = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        // Do any additional setup after loading the view.
        self.locationManager.delegate = self

        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            self.mapView.showsUserLocation = true
            self.locationManager.startUpdatingLocation()


        }else{
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]){

        let myArea = MKCoordinateRegionMakeWithDistance(self.locationManager.location!.coordinate, 1000, 1000)
        self.mapView.setRegion(myArea, animated: true)

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

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
