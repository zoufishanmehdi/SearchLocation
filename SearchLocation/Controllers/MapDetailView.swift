//
//  MapDetailView.swift
//  SearchLocation
//
//  Created by Zoufishan Mehdi on 3/2/19.
//  Copyright © 2019 Zoufishan Mehdi. All rights reserved.
//

import UIKit
import MapKit

class MapDetailView: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var selectedLocation: CityViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("selected city \(selectedLocation?.fullString ?? "")")
        setupNavBar()
        showLocationCoords()
    }
    
    func showLocationCoords() {
        let location = CLLocationCoordinate2D(latitude: selectedLocation?.latitude ?? 0.0, longitude: selectedLocation?.longitude ?? 0.0)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = selectedLocation?.cityName
        mapView.addAnnotation(annotation)
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "\(selectedLocation?.cityName ?? "")"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red:0.22, green:0.41, blue:0.76, alpha:1.0)
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
       navigationController?.navigationBar.tintColor = .white
    }
}
