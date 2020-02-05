//
//  MainWeatherStats.swift
//  CitiesWeather
//
//  Created by Abraham Escamilla Pinelo on 04/02/20.
//  Copyright © 2020 Abraham Escamilla Pinelo. All rights reserved.
//

import Foundation

struct MainWeatherStats: Codable {
    var temp: Double
    var feelsLike: Double
    var tempMin: Double
    var tempMax: Double
    var pressure: Double
    var humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp, humidity, pressure
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
