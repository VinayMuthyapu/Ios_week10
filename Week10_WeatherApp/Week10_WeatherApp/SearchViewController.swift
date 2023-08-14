//
//  ViewController.swift
//  Week10_WeatherApp
//
//  Created by Rania Arbash on 2023-07-17.
//

import UIKit

class SearchViewController: UIViewController , UISearchBarDelegate , NetworkingDelegate, UITableViewDelegate,UITableViewDataSource {
 
   
    var allCiteis = [String]()
    
    @IBOutlet weak var citiesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NetworkingManger.shared.delegate = self
    }


    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.count > 2 {
            // call the api
            NetworkingManger.shared.getCitiesFromAPI(searchText: searchText)
            
        }else {
            allCiteis = [String]()
            citiesTable.reloadData()
            
        }
        
        
    }
    
    
    
    func networkingDidFinishWithLitsOfCities(cities: [String]) {
        
        allCiteis = cities
        citiesTable.reloadData()
    }
    
    func networkingDidFail() {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var alert = UIAlertController(title: "Fav City??", message: "Would you like to save this city?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default,handler: { action in
           
            (UIApplication.shared.delegate as! AppDelegate).favCities.append(self.allCiteis[indexPath.row])
            self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .destructive))
        
        present(alert, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCiteis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = citiesTable.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = allCiteis[indexPath.row]
        
        return cell!
        
    }
    
}

