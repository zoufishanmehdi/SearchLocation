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
    var mapView = MKMapView()
    
    var cityViewModel: CityViewModel
    init(cityViewModel: CityViewModel) {
        self.cityViewModel = cityViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "\(cityViewModel.cityName)"
        self.navigationController?.navigationBar.styleNavigationBar()
        
        setupMap()
        showLocationCoords()
    }
    
    func setupMap() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mapView)
        
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func showLocationCoords() {
        let location = CLLocationCoordinate2D(latitude: cityViewModel.latitude, longitude: cityViewModel.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = cityViewModel.cityName
        mapView.addAnnotation(annotation)
    }
}
