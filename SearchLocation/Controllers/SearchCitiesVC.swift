//
//  SearchCitiesVC.swift
//  SearchLocation
//
//  Created by Zoufishan Mehdi on 3/2/19.
//  Copyright © 2019 Zoufishan Mehdi. All rights reserved.
//

import UIKit

class SearchCitiesVC: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var cityViewModels = [CityViewModel]()
    var filteredCities: [CityViewModel] = []
    var searchActive: Bool = false
    var selectedIndexPath: Int = 0
    let cellId = "cityCell"
    let segueId = "mapDetailSeg"
    
    var selectionHandler: ((CityViewModel) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
     
        navigationItem.title = "Search Locations"
        navigationController?.navigationBar.styleNavigationBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        fetchData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        
        searchBar.text = nil
        searchBar.resignFirstResponder()
        tableView.resignFirstResponder()
        self.searchBar.showsCancelButton = false
        tableView.reloadData()
    }
    
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchActive = true
        filteredCities = searchText.isEmpty ? cityViewModels : cityViewModels.filterByCity(searchText: searchText)
         self.tableView.reloadData()
    }
}


extension SearchCitiesVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filteredCities.count
        } else {
            return cityViewModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.selectionStyle = .none
        if searchActive {
            cell.textLabel?.text = filteredCities[indexPath.row].fullString
        } else {
            cell.textLabel!.text = cityViewModels[indexPath.row].fullString
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchActive {
            if filteredCities.count > selectedIndexPath {
                let mapDetailView =  MapDetailView(cityViewModel: filteredCities[indexPath.row])
                navigationController?.pushViewController(mapDetailView, animated: true)
            }
        } else {
            if cityViewModels.count > selectedIndexPath {
                let mapDetailView =  MapDetailView(cityViewModel: cityViewModels[indexPath.row])
                navigationController?.pushViewController(mapDetailView, animated: true)
            }
        }
    }
}


private extension SearchCitiesVC {
    
    func fetchData() {
        Service.shared.fetchLocation { result in
            switch result {
            case .success(let cities):
                self.cityViewModels = cities
                    .compactMap { CityViewModel(city: $0) }
                    .sortedByCityThenCountryName()
                
                self.tableView.reloadData()
                
            case .failure(let error):
                // TODO: handle the error
                print("Failed to fetch cities", error)
            }
        }
    }
}
