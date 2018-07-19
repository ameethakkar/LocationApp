//
//  MyLocationViewController.swift
//  LocationApp
//
//  Created by Amee Thakkar on 7/18/18.
//  Copyright © 2018 Amee Thakkar. All rights reserved.
//

import UIKit
import MapKit

class MyLocationViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    let locationManager : CLLocationManager = CLLocationManager()
    var oldLocation : CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        oldLocation = nil
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 20
        
        //if the user is constant, you don't need to check location
        // locationManager.requestLocation()
        
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let region = MKCoordinateRegionMakeWithDistance((locations.last?.coordinate)!, 500, 500)
        mapView.setRegion(region, animated: true)
        
        if oldLocation == nil {
            oldLocation = locations.first
        }
        let newLocation = locations.last
        let distance = newLocation?.distance(from: oldLocation!)
        
        if let distance = distance {
            distanceLabel.text = String(format: "%0.1f meters", distance)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }


}
