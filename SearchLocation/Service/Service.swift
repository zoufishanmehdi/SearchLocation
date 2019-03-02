//
//  Service.swift
//  SearchLocation
//
//  Created by Zoufishan Mehdi on 3/2/19.
//  Copyright © 2019 Zoufishan Mehdi. All rights reserved.
//

import Foundation

class Service: NSObject {
    static let shared = Service()
    
    func fetchLocation(completion: @escaping ([City]?, Error?) -> ()) {
    
        guard let url = Bundle.main.url(forResource: "cities", withExtension: "json") else {
            return
        }
        guard let data = try? Data(contentsOf: url) else { return }
        do {
            let cities = try JSONDecoder().decode([City].self, from: data)
            DispatchQueue.main.async {
                completion(cities, nil)
            }
        } catch let jsonErr {
            print("Failed to decode:", jsonErr)
        }
    }
}
