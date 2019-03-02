//
//  CityViewModel.swift
//  SearchLocation
//
//  Created by Zoufishan Mehdi on 3/2/19.
//  Copyright © 2019 Zoufishan Mehdi. All rights reserved.
//

import Foundation

struct CityViewModel {
    let name: String
    let latitude: Double
    let longitude: Double
    
    init(city: City) {
        name = "\(city.name), \(city.country)"
        latitude = city.coord.lat
        longitude = city.coord.lon
    }
}
