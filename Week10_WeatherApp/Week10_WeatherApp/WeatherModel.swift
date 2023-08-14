//
//  WeatherModel.swift
//  Week10_WeatherApp
//
//  Created by Rania Arbash on 2023-07-18.
//

import Foundation


class WeatherModel : Decodable {
    
    var weather : [WeatherInfo] = [WeatherInfo]()
    var main : MainInfo = MainInfo()
    var visibility : Int = 0
}

class WeatherInfo : Decodable {
    var main : String = ""
    var description : String = ""
    var icon : String = ""
}

class MainInfo  : Decodable{
    var temp : Double = 0.0
    var feels_like: Double = 0.0
    var humidity : Int  = 0
}
