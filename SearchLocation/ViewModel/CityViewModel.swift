//
//  CityViewModel.swift
//  SearchLocation
//
//  Created by Zoufishan Mehdi on 3/2/19.
//  Copyright © 2019 Zoufishan Mehdi. All rights reserved.
//

import Foundation

struct CityViewModel {
    let cityName: String
    let countryName: String
    let fullString: String
    let latitude: Double
    let longitude: Double
    
    init(city: City) {
        cityName = city.name
        countryName = city.country
        fullString = "\(city.name), \(city.country)"
        latitude = city.coord.lat
        longitude = city.coord.lon
    }
}


extension Array where Element == CityViewModel {
    
    func sortedByCityThenCountryName() -> [CityViewModel] {
        return sorted { $0.cityName == $1.cityName ? $0.countryName < $1.countryName : $0.cityName < $1.cityName }
    }
    
    func filterByCityThenCountryName(searchText: String) -> [CityViewModel] {
        return filter({ (city: CityViewModel) -> Bool in
            city.fullString.range(of: searchText, options: .caseInsensitive, range: city.fullString.range(of: city.cityName), locale: nil) != nil
        })
    }
}
