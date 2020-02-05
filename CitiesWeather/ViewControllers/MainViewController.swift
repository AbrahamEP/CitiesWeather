//
//  MainViewController.swift
//  CitiesWeather
//
//  Created by Abraham Escamilla Pinelo on 04/02/20.
//  Copyright © 2020 Abraham Escamilla Pinelo. All rights reserved.
//

import UIKit
import MapKit
import MBProgressHUD

class MainViewController: UIViewController {
    
    //MARK: - UI
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var feelsLikeTempLabel: UILabel!
    
    //MARK: - Variables
    var city: City!
    var weather: Weather! {
        didSet {
            self.setWeatherInfo()
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    //MARK: - Setup methods
    private func setup() {
        self.setupMapView()
        self.setupSegmentedControl()
        self.setupLabels()
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.callWeatherAPI {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    private func setupLabels() {
        self.temperatureLabel.adjustsFontSizeToFitWidth = true
        self.maxTempLabel.adjustsFontSizeToFitWidth = true
        self.minTempLabel.adjustsFontSizeToFitWidth = true
        self.humidityLabel.adjustsFontSizeToFitWidth = true
        self.feelsLikeTempLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setupMapView() {
        self.mapView.delegate = self
        self.city = City(rawValue: 0)
        self.setMapFocus(centerCoordinate: self.city.location, radiusInKm: 20)
    }
    
    private func setMapFocus(centerCoordinate: CLLocationCoordinate2D, radiusInKm radius: CLLocationDistance)
    {
        let diameter = radius * 2000
        let region: MKCoordinateRegion = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: diameter, longitudinalMeters: diameter)
        self.mapView.setRegion(region, animated: false)
    }
    
    private func setupSegmentedControl() {
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChangedAction), for: .valueChanged)
    }
    
    //MARK: - Helper methods
    
    private func setWeatherInfo() {
        self.temperatureLabel.text = "\(self.weather.main.temp)°"
        self.minTempLabel.text = "Min \(self.weather.main.tempMin)°"
        self.maxTempLabel.text = "Max \(self.weather.main.tempMax)°"
        self.humidityLabel.text = "Humidity: \(self.weather.main.humidity) %"
        self.feelsLikeTempLabel.text = "Feels like: \(self.weather.main.feelsLike)°"
        self.title = self.weather.name
        
        let marker = MapMarker(title: "Temp \(self.weather.main.temp)", subtitle: "Max: \(self.weather.main.tempMax)°, Min: \(self.weather.main.tempMin)°", coordinate: self.city.location)
        self.mapView.addAnnotation(marker)
    }
    
    private func callWeatherAPI(completion: @escaping () -> Void) {
        WeatherAPI.getWeather(from: self.city.location) { [weak self] (error, weather) in
            guard let self = self else {return}
            if let _ = error {
                //There is an error
                completion()
                self.showAlertOneButtonWith(alertTitle: "An error ocurred", alertMessage: "Try again later", buttonTitle: "Ok")
            } else {
                guard let weather = weather else {
                    completion()
                    self.showAlertOneButtonWith(alertTitle: "An error ocurred", alertMessage: "Try again later", buttonTitle: "Ok")
                    return
                }
                //Without error
                self.weather = weather
                completion()
            }
        }
    }
    
    //MARK: - Actions
    @objc func segmentedControlValueChangedAction() {
        self.city = City(rawValue: self.segmentedControl.selectedSegmentIndex)
        
        self.mapView.setCenter(self.city.location, animated: true)
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.callWeatherAPI {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
        
    }
}

extension MainViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      
        guard let annotation = annotation as? MapMarker else { return nil }
          
        let identifier = "marker"
        var view: MKMarkerAnnotationView
          
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            
            dequeuedView.annotation = annotation
            view = dequeuedView
            
        } else {
            
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        view.displayPriority = .required
        return view
    }
}
