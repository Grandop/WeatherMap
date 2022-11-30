//
//  Weather.swift
//  WeatherMap
//
//  Created by Pedro Grando on 24/11/22.
//

import Foundation


struct Weather: Codable {
    var main: Main
    var name: String
    
    var tempFormat: String {
        return String(format: "%0.f", main.temp)
    }
    
    
    enum CodingKeys: CodingKey {
        case main
        case name
    }
    
}

