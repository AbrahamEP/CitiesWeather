//
//  City.swift
//  CitiesWeather
//
//  Created by Abraham Escamilla Pinelo on 04/02/20.
//  Copyright © 2020 Abraham Escamilla Pinelo. All rights reserved.
//

import Foundation
import CoreLocation

enum City: Int {
    case cdmx = 0, guadalajara, monterrey
    var location: CLLocationCoordinate2D {
        switch self {
        case .cdmx:
            return CLLocationCoordinate2D(latitude: 19.432977, longitude: -99.133368)
        case .guadalajara:
            return CLLocationCoordinate2D(latitude: 20.675424, longitude: -103.339536)
        case .monterrey:
            return CLLocationCoordinate2D(latitude: 25.683348, longitude: -100.316841)
        }
    }
}
