//
//  SearchAddressViewController.swift
//  LocationApp
//
//  Created by Amee Thakkar on 7/18/18.
//  Copyright © 2018 Amee Thakkar. All rights reserved.
//

import UIKit
import MapKit

class SearchAddressViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addressTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let addressGeocoder = CLGeocoder()
        addressGeocoder.geocodeAddressString(addressTextField.text!) { (placemarks, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let placemarks = placemarks {
                let firstPlacemark = placemarks[0]
                
                let annotation = MKPointAnnotation()
                annotation.title = "This is the title"
                annotation.subtitle = "Subtitle - 5769865"
                
                if let location = firstPlacemark.location {
                    
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
                
               /*
                // to zoom the map
                let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 500, 500)
                self.mapView.setRegion(region, animated: true)
                 */
            }
        }
        return true
    }
   

}
