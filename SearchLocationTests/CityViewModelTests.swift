//
//  CityViewModelTests.swift
//  SearchLocationTests
//
//  Created by Zoufishan Mehdi on 3/3/19.
//  Copyright © 2019 Zoufishan Mehdi. All rights reserved.
//

import XCTest
@testable import SearchLocation

class CityViewModelTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testInitialization() {
        let city = City(country: "US", name: "Alabama", _id: 4829764, coord: Coordinates(lat: 32.750408, lon: -86.750259))
        let cityViewModel = CityViewModel(city: city)
        
        XCTAssertEqual(city.name, cityViewModel.cityName)
        XCTAssertEqual(city.coord.lat, cityViewModel.latitude)
    }
    
    func testCityViewModelSorting() {
        let city1 = City(country: "US", name: "Alabama", _id: 4829764, coord: Coordinates(lat: 32.750408, lon: -86.750259))
        let city2 = City(country: "US", name: "Falls County", _id: 4690103, coord: Coordinates(lat: 31.26684, lon: -96.933601))
        let city3 = City(country: "US", name: "Cego", _id: 4679930, coord: Coordinates(lat: 31.24518, lon: -97.162498))
        let city4 = City(country: "AI", name: "Cego", _id: 4679930, coord: Coordinates(lat: 31.24518, lon: -97.162498))
        

        let cityViewModels = [city1, city2, city3, city4].map { CityViewModel(city: $0) }
        let sortedCityViewModels = cityViewModels.sortedByCityThenCountryName()
        
        XCTAssertTrue(sortedCityViewModels[0].cityName == "Alabama")
        XCTAssertTrue(sortedCityViewModels[1].cityName == "Cego")
        XCTAssertTrue(sortedCityViewModels[1].countryName == "AI")
        XCTAssertTrue(sortedCityViewModels[2].cityName == "Cego")
        XCTAssertTrue(sortedCityViewModels[2].countryName == "US")
        XCTAssertTrue(sortedCityViewModels[3].cityName == "Falls County")
    }
    
    func testCityViewModelFiltering() {
        let city1 = City(country: "US", name: "Alabama", _id: 4829764, coord: Coordinates(lat: 32.750408, lon: -86.750259))
        let city2 = City(country: "US", name: "Falls County", _id: 4690103, coord: Coordinates(lat: 31.26684, lon: -96.933601))
        let city3 = City(country: "US", name: "Cego", _id: 4679930, coord: Coordinates(lat: 31.24518, lon: -97.162498))
        let city4 = City(country: "AI", name: "Cego", _id: 4679930, coord: Coordinates(lat: 31.24518, lon: -97.162498))
        
        let cityViewModels = [city1, city2, city3, city4].map { CityViewModel(city: $0) }
        let sortedCityViewModels = cityViewModels.filterByCity(searchText: "Cego")
        
        XCTAssertTrue(sortedCityViewModels[0].cityName == "Cego")
    }
        
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

