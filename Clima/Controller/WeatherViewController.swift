//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UITextField!
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    private var weatherManager = WeatherAPI()
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//MARK: - Extensions
extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        print(searchBar.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.endEditing(true)
        // This tells that the user pressed the return/go key, this should search for the city and hide the soft keyboard
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // This is useful for validation
        if textField.text != "" {
            return true
        }
        
        textField.placeholder = "Type something"
        
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Use Optional Binding
        if let userInput = searchBar.text {
            weatherManager.fetchWeather(cityName: userInput)
        }
        
        searchBar.text = ""
    }
}

extension WeatherViewController: WeatherAPIDelegate {
    func didUpdateWeather(_ data: WeatherData) {
        temperatureLabel.text = String(format: "%.1f", data.temperature)
        conditionImageView.image = UIImage(systemName: data.conditionName)
        cityLabel.text = data.name
    }
    
    func didFailWithError(_ error: Error) {
        //TODO: Manage the error
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            weatherManager.fetchWeather(latitude: latitude, longitude: longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //TODO:
    }
}

