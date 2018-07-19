//
//  SearchMapViewController.swift
//  LocationApp
//
//  Created by Amee Thakkar on 7/18/18.
//  Copyright © 2018 Amee Thakkar. All rights reserved.
//

import UIKit
import MapKit

class SearchMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func textFieldEndExit(_ sender: Any) {
        
        searchTextField.resignFirstResponder()
        
        // To remove the annotations of previous search
        mapView.removeAnnotations(mapView.annotations)
        
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchTextField.text ?? "Pizza"
        
        searchRequest.region = mapView.region
        
        let mapSearch = MKLocalSearch(request: searchRequest)
        
        mapSearch.start { (searchResponse, error) in
            
            if error != nil {
                print(error!)
                return
            }
            else if searchResponse?.mapItems.count == 0 {
                print("No items found")
            }
            else {
                
                for singleItem in (searchResponse?.mapItems)! {
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = singleItem.placemark.coordinate
                    annotation.title = singleItem.name ?? "No Name"
                    annotation.subtitle = singleItem.phoneNumber ?? "No Phone"
                    
                    self.mapView.addAnnotation(annotation)
                    self.mapView.showAnnotations([annotation], animated: true)
                }
            }
        }
    }
    


}
