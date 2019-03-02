//
//  City.swift
//  SearchLocation
//
//  Created by Zoufishan Mehdi on 3/2/19.
//  Copyright © 2019 Zoufishan Mehdi. All rights reserved.
//

import Foundation

struct City: Decodable {
    let country: String
    let name: String
    let _id: Int
    let coord: Coordinates
}

struct Coordinates: Decodable {
    let lat: Double
    let lon: Double 
}
