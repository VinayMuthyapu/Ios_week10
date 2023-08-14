//
//  FavCitiesTableViewController.swift
//  Week10_WeatherApp
//
//  Created by Rania Arbash on 2023-07-18.
//

import UIKit

class FavCitiesTableViewController: UITableViewController, UISearchBarDelegate {

    var favCities = (UIApplication.shared.delegate as! AppDelegate).favCities
    var weatherObject = WeatherModel()
    
    var filteredCities: [String] = []
        var isSearching = false

        @IBOutlet weak var searchBar: UISearchBar!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self

            }

    override func viewWillAppear(_ animated: Bool) {
        favCities = (UIApplication.shared.delegate as! AppDelegate).favCities
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return favCities.count
        return isSearching ? filteredCities.count : favCities.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let city = isSearching ? filteredCities[indexPath.row] : favCities[indexPath.row]
        cell.textLabel?.text = city

        return cell

    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
       
            favCities.remove(at: indexPath.row)
            tableView.reloadData()
            
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetails"{
            
            var city = favCities[tableView.indexPathForSelectedRow!.row].replacingOccurrences(of: " ", with: "%20")
            
            let weatherVC = segue.destination as! WeatherDetailsViewController
            weatherVC.city = city
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                isSearching = false
                filteredCities = []
            } else {
                isSearching = true
                filteredCities = favCities.filter { $0.localizedCaseInsensitiveContains(searchText) }
            }
            tableView.reloadData()
        }

}
