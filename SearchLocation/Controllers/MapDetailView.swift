//
//  MapDetailView.swift
//  SearchLocation
//
//  Created by Zoufishan Mehdi on 3/2/19.
//  Copyright © 2019 Zoufishan Mehdi. All rights reserved.
//

import UIKit

class MapDetailView: UIViewController {
    var selectedCity: CityViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("selected city \(selectedCity?.fullString ?? "")")
        setupNavBar()
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "\(selectedCity?.cityName ?? "")"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red:0.22, green:0.41, blue:0.76, alpha:1.0)
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
       navigationController?.navigationBar.tintColor = .white
    }
}
