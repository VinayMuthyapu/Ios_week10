//
//  WeatherDetailsViewController.swift
//  Week10_WeatherApp
//
//  Created by Rania Arbash on 2023-07-18.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    var city : String = ""
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBOutlet weak var tempText: UILabel!
    
    
    @IBOutlet weak var feelsLikeText: UILabel!
    
    @IBOutlet weak var descriptionText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.isHidden = false
//
//        NetworkingManger.shared.getWeather2(city: city) { result in
//
//            switch (result) {
//            case .failure(let error) :
//                print ("error")
//
//
//            case .success (let weatherObject ) :
//
//                    self.descriptionText.text = weatherObject.weather.first?.description
//                    self.tempText.text = "\(weatherObject.main.temp)"
//                    self.feelsLikeText.text = "\(weatherObject.main.feels_like)"
//
//                    downloadIcon(icon: weatherObject.weather.first!.icon)
//                break
//
//        }
//
        
            NetworkingManger.shared.getWeather(city: self.city) { weatherOBJ in
            if let goodWeatherObj = weatherOBJ  {
                var weatherObject = goodWeatherObj
                
                
                self.descriptionText.text = weatherObject.weather.first?.description
                self.tempText.text = "\(weatherObject.main.temp)"
                self.feelsLikeText.text = "\(weatherObject.main.feels_like)"
               
                self.downloadIcon(icon: weatherObject.weather.first!.icon)
                
                
            }
        }

    }

    
    func downloadIcon(icon : String){
        ////
        
        let iconURL = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        let myQ = DispatchQueue.init(label: "myq")
        myQ.async {
            do{
                var imageData = try Data(contentsOf: URL(string: iconURL)!)
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: imageData)
                    self.loading.isHidden = true
                }
            }catch {
                print (error)
            }
        }
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
