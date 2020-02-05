//
//  WeatherAPI.swift
//  CitiesWeather
//
//  Created by Abraham Escamilla Pinelo on 04/02/20.
//  Copyright © 2020 Abraham Escamilla Pinelo. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

enum WeatherRouter: APIConfiguration {
    
    case getWeather(lat: Double, long: Double)
    
    var method: HTTPMethod {
        switch self {
        case .getWeather:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getWeather:
            return "weather"
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getWeather:
            return URLEncoding.default
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getWeather(let lat, let long):
            return ["lat": lat, "lon": long, "APPID": "cd4676ddc34bc8d1617907c3b230f3a6", "units": "metric"]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = try DCAPIManager.shared.host.asURL()
        url.appendPathComponent(DCAPIManager.shared.apiVersion)
        url.appendPathComponent(path)
        
        var urlRequest = try URLRequest(url: url, method: method)
        urlRequest = try encoding.encode(urlRequest, with: parameters)
        
        return urlRequest
    }
}

final class WeatherAPI {
    static func getWeather(from location: CLLocationCoordinate2D, completion: @escaping (_ error: ResponseError?, _ weather: Weather?) -> Void) {
        
        DCAPIManager.shared.request(urlRequest: WeatherRouter.getWeather(lat: location.latitude, long: location.longitude)) { (error, weather: Weather?) in
            
            DispatchQueue.main.async {
                completion(error, weather)
            }
        }
    }
}
