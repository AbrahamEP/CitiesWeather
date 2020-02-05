//
//  Weather.swift
//  CitiesWeather
//
//  Created by Abraham Escamilla Pinelo on 04/02/20.
//  Copyright © 2020 Abraham Escamilla Pinelo. All rights reserved.
//

import Foundation

struct Weather: Codable {
    var main: MainWeatherStats
    var name: String
}
