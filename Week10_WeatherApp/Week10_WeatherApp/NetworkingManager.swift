//
//  NetworkingManager.swift
//  Week10_WeatherApp
//
//  Created by Rania Arbash on 2023-07-17.
//

import Foundation

protocol NetworkingDelegate {
    func networkingDidFinishWithLitsOfCities(cities : [String])
    func networkingDidFail()
}

class NetworkingManger {

    
    // let urlString =  "https://api.openweathermap.org/data/2.5/weather?q=cityName&appid=071c3ffca10be01d334505630d2c1a9c"
    
    
        static var shared = NetworkingManger()
        var delegate : NetworkingDelegate?
        
    func getCitiesFromAPI(searchText : String) {
            let strinurl = "http://gd.geobytes.com/AutoCompleteCity?&q="+searchText
            guard let urlObj = URL(string: strinurl) else { return }
            // datatask runs in background thread
            
            let task = URLSession.shared.dataTask(with: urlObj) { data, response, error in
                
                if error != nil { // there is an error
                    print (error!)
                    DispatchQueue.main.async {
                        self.delegate?.networkingDidFail()
                    }
                    // let my delegate know about this error
                }
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    DispatchQueue.main.async {
                        self.delegate?.networkingDidFail()
                    }
                    return
                }
                if let goodData = data {
                    // let string = String(data: goodData, encoding: .utf8)
                    //print (string ?? "")
                    
                    // convert the data into list of Cities.
                    DispatchQueue.main.async {
                        do {
                            
                            let jsonDecoder = JSONDecoder()
                           // array of strings
                            //Rome City, IN, United States
                            //
                            
                            let citiesArray = try jsonDecoder.decode([String].self, from: goodData)
                            
                            self.delegate?.networkingDidFinishWithLitsOfCities(cities: citiesArray)
                            
                           
                        }
                        catch {
                            print (error)
                        }
                        
                       
                    }
                    
                }
            }
            
            task.resume()// run in background thread by default
            
        }
    
    
    func getWeather(city: String, handler : @escaping (WeatherModel?)->Void ){
    
        let stringurl =  "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=071c3ffca10be01d334505630d2c1a9c"
        // New York, ON, Canada
        guard let urlObj = URL(string: stringurl) else {
            print("error")
            return }
        // datatask runs in background thread
        
        let task = URLSession.shared.dataTask(with: urlObj) { data, response, error in
            
            if error != nil { // there is an error
                print (error!)
                DispatchQueue.main.async {
                       // error
                    handler(nil)

                }
                // let my delegate know about this error
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    // no good response
                    handler(nil)
                }
                return
            }
            if let goodData = data {
               DispatchQueue.main.async {
                    
                    do {
                        
                        let jsonDecoder = JSONDecoder()

                        let weatherObject = try jsonDecoder.decode(WeatherModel.self, from: goodData)
                        // we have a good weather object
                        
//                        let jsonDic =  try JSONSerialization.jsonObject(with: goodData) as! NSDictionary
//                        let weatherArray = jsonDic.value(forKey: "weather") as! NSArray
//                        var weatherOBJDic = weatherArray.firstObject as! NSDictionary
//                        print( weatherOBJDic.value(forKey: "description") as! String)
//
                        handler(weatherObject)
                    }
                    catch {
                        print (error)
                    }
                }
            }
        }
        
        task.resume()// run in background thread by default
      
        
    }
    func getWeather2(city: String, handler : @escaping (Result<WeatherModel,Error>)->Void ){
    
        let stringurl =  "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=071c3ffca10be01d334505630d2c1a9c"
        // New York, ON, Canada
        guard let urlObj = URL(string: stringurl) else {
            print("error")
            return }
        // datatask runs in background thread
        
        let task = URLSession.shared.dataTask(with: urlObj) { data, response, error in
            
            if error != nil { // there is an error
                print (error!)
                DispatchQueue.main.async {
                       // error
                    handler(.failure(error!))

                }
                // let my delegate know about this error
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    // no good response
                    handler(.failure(fatalError("No good response")))
                }
                return
            }
            if let goodData = data {
               DispatchQueue.main.async {
                    
                    do {
                        
                        let jsonDecoder = JSONDecoder()

                        let weatherObject = try jsonDecoder.decode(WeatherModel.self, from: goodData)
                        // we have a good weather object
                        
//                        let jsonDic =  try JSONSerialization.jsonObject(with: goodData) as! NSDictionary
//                        let weatherArray = jsonDic.value(forKey: "weather") as! NSArray
//                        var weatherOBJDic = weatherArray.firstObject as! NSDictionary
//                        print( weatherOBJDic.value(forKey: "description") as! String)
//
                        handler(.success(weatherObject))
                    }
                    catch {
                        print (error)
                    }
                }
            }
        }
        
        task.resume()// run in background thread by default
      
        
    }
 
    
    }

    

