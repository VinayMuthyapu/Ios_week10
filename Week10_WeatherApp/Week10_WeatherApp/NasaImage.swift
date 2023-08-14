//
//  NasaImage.swift
//  Week10_WeatherApp
//
//  Created by Rania Arbash on 2023-07-24.
//

import Foundation

class NasaImage : Decodable , Encodable {
    
    var id : Int = 0
    var camera : Camera = Camera()
    var img_src : String = ""
    var earth_date : String = ""
    
    
}

class Camera : Decodable , Encodable{
    
    var id: String = ""
    var full_name : String = ""
}
