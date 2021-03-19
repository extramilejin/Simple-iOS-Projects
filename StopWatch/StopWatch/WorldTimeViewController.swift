//
//  WorldTimeViewController.swift
//  StopWatch
//
//  Created by 진형진 on 2021/03/14.
//

import UIKit
import Foundation

class WorldTimeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    var AddedWorldTimes: [String] = TimeZone.knownTimeZoneIdentifiers
    
    // MARK: - Actions
    
    @IBAction func touchUpWTEditButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddedWorldTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = AddedWorldTimes[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WTCell", for: indexPath) as? WorldTimeTableViewCell else {
            return WorldTimeTableViewCell()
        }
        cell.cityNameLabel.text = row
        return cell
    }

}
