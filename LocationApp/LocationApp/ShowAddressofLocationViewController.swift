//
//  ShowAddressofLocationViewController.swift
//  LocationApp
//
//  Created by Amee Thakkar on 7/18/18.
//  Copyright © 2018 Amee Thakkar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ShowAddressofLocationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    var locationManager : CLLocationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Show Address"
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 20
        
        mapView.showsUserLocation = true
        mapView.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let region = MKCoordinateRegionMakeWithDistance((locations.last?.coordinate)!, 5000, 5000)
        
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        let location = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            if (placemarks?.count)! > 0
            {
                let singlePlacemark = placemarks![0]
                let addressDict = singlePlacemark.addressDictionary
                
                // print(addressDict)
                
                let street = addressDict!["Street"] ?? ""
                let city = addressDict!["City"] ?? ""
                let state = addressDict!["State"] ?? ""
                let zip = addressDict!["ZIP"] ?? ""
                
                self.addressLabel.text = "\(street), \(city), \(state) \(zip)"
            }
            
        }
    }
    

}
