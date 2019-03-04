//
//  Service.swift
//  SearchLocation
//
//  Created by Zoufishan Mehdi on 3/2/19.
//  Copyright © 2019 Zoufishan Mehdi. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

final class Service {
    static let shared = Service()
    
    func fetchLocation(completion: @escaping (Result<[City]>) -> ()) {
        guard
            let url = Bundle.main.url(forResource: "cities", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                fatalError("Unable to read cities json.")
        }
        
        do {
            let cities = try JSONDecoder().decode([City].self, from: data)
            DispatchQueue.main.async {
                completion(.success(cities))
            }
        } catch {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
}
