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
     
        setupNavBar()
        fetchData()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
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
        filteredCities = searchText.isEmpty ? cityViewModels : cityViewModels.filterByCityThenCountryName(searchText: searchText)
         self.tableView.reloadData()
    }
    
    fileprivate func fetchData() {
        Service.shared.fetchLocation { result in
            switch result {
            case .success(let cities):
                self.cityViewModels = cities
                    .compactMap { CityViewModel(city: $0) }
                    .sortedByCityThenCountryName()
                
                print("\(self.cityViewModels[0].cityName)")
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            case .failure(let error):
                // TODO: handle the error
                print("Failed to fetch cities", error)
            }
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

extension UINavigationBar {
    func styleWhite() {
        prefersLargeTitles = true
        isTranslucent = false
        barTintColor = UIColor(red:0.22, green:0.41, blue:0.76, alpha:1.0)
        largeTitleTextAttributes = [.foregroundColor: UIColor.white]
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
        selectedIndexPath = indexPath.row
        self.performSegue(withIdentifier: segueId, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueId {
            guard let mapDetailView = segue.destination as? MapDetailView else { return }
            if searchActive {
                if filteredCities.count > selectedIndexPath {
                    mapDetailView.cityViewModel = filteredCities[selectedIndexPath]
                }
            } else {
                if cityViewModels.count > selectedIndexPath {
                    mapDetailView.cityViewModel = cityViewModels[selectedIndexPath]
                }
            }
        }
    }
}
