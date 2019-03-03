//
//  SearchLocationTests.swift
//  SearchLocationTests
//
//  Created by Zoufishan Mehdi on 3/2/19.
//  Copyright © 2019 Zoufishan Mehdi. All rights reserved.
//

import XCTest
@testable import SearchLocation

class SearchLocationTests: XCTestCase {

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
    
    func testSearchQuery() {
        let searchCityVC = SearchCitiesVC()
        searchCityVC.tableView = UITableView()
        searchCityVC.searchBar = UISearchBar()
        
        var city1 = City(country: "US", name: "Alabama", _id: 4829764, coord: Coordinates(lat: 32.750408, lon: -86.750259))
        var city2 = City(country: "US", name: "Falls County", _id: 4690103, coord: Coordinates(lat: 31.26684, lon: -96.933601))
        var city3 = City(country: "US", name: "Cego", _id: 4679930, coord: Coordinates(lat: 31.24518, lon: -97.162498))
  
        searchCityVC.cityViewModels.append(CityViewModel(city: city1))
        searchCityVC.cityViewModels.append(CityViewModel(city: city2))
        searchCityVC.cityViewModels.append(CityViewModel(city: city3))
        
        XCTAssertTrue(searchCityVC.cityViewModels.count == 3)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
