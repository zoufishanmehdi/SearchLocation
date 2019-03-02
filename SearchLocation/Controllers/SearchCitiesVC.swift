//
//  SearchCitiesVC.swift
//  SearchLocation
//
//  Created by Zoufishan Mehdi on 3/2/19.
//  Copyright © 2019 Zoufishan Mehdi. All rights reserved.
//

import UIKit

class SearchCitiesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var cityViewModels = [CityViewModel]()
    let cellId = "cityCell"

    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupNavBar()
        fetchData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel!.text = "Alabama, US"
        return cell
    }
    
    
    fileprivate func fetchData() {
        Service.shared.fetchLocation { (cities, err) in
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            
            self.cityViewModels = cities?.map({return CityViewModel(city: $0)}) ?? []
            print("\(self.cityViewModels[0].name)")
            self.tableView.reloadData()
        }
    }

    fileprivate func setupNavBar() {
        navigationItem.title = "Search Locations"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red:0.22, green:0.41, blue:0.76, alpha:1.0)
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
