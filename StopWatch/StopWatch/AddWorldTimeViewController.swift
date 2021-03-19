//
//  AddWorldTimeViewController.swift
//  StopWatch
//
//  Created by 진형진 on 2021/03/14.
//

import UIKit
import Foundation

class AddWorldTimeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchBarDelegate {
    
    // MARK: - Properties
    fileprivate var worldTimes: [String]!
    fileprivate var filteredWorldTimes: [String]!
    fileprivate var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = self.navigationItem.searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    // MARK: - Outlets
    @IBOutlet weak var addWTTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTimeZone()
        self.setUpTableView()
        self.setUpSearchController()
    }
    
    // MARK: - UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredWorldTimes.count : worldTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddWTCell", for: indexPath) as? AddWorldTimeTableViewCell else {
            return AddWorldTimeTableViewCell()
        }
        if isFiltering {
            cell.addWTCityNameLabel.text = filteredWorldTimes[indexPath.row]
        } else {
            cell.addWTCityNameLabel.text = worldTimes[indexPath.row]
        }
        return cell
    }
    
    // MARK: - Helper

    fileprivate func setUpTimeZone() {
        worldTimes = TimeZone.knownTimeZoneIdentifiers.map {
            let localizedName = TimeZone(identifier: $0)?.localizedName(for: .shortGeneric, locale: Locale(identifier: "ko_KR")) ?? ""
            return localizedName
        }
        worldTimes.sort(by: <)
    }
    
    fileprivate func setUpTableView() {
        addWTTableView.delegate = self
        addWTTableView.dataSource = self
        addWTTableView.reloadData()
    }
    
    fileprivate func setUpSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.barStyle = .black
        
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "도시 검색"
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }

}

extension AddWorldTimeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = self.navigationItem.searchController?.searchBar.text else { return }
        self.filteredWorldTimes = self.worldTimes.filter { $0.contains(text) }
        self.addWTTableView.backgroundColor = .black
        self.addWTTableView.reloadData()
    }
}
        
    


