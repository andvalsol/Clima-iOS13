//
//  WeatherManager.swift
//  Clima
//
//  Created by Andrey Solera on 8/7/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherAPI {
    let weatherURL = "https://api.openweathermap.org/data/2.5/..."
    
    var delegate: WeatherAPIDelegate?
    
    func fetchWeather(cityName name: String) {
        let urlString = "\(weatherURL)&q=\(name)"
        
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        
        performRequest(with: urlString)
    }
    
    private func performRequest(with url: String) {
        if let URL = URL(string: url) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: URL) { (data, response, error) in
                if let safeError = error {
                    delegate?.didFailWithError(safeError)
                    
                    return
                }
                
                if let safeData = data {
                    if let weatherData = parseJSON(data: safeData) {
                        DispatchQueue.main.sync {
                            delegate?.didUpdateWeather(weatherData)
                        }
                    }
                    
                }
            }
            
            task.resume()
        }
    }
    
    private func parseJSON(data: Data) -> WeatherData? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(WeatherData.self, from: data)
        } catch {
            delegate?.didFailWithError(error)
            
            return nil
        }
    }
}

