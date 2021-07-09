//
//  WeatherAPIDelegate.swift
//  Clima
//
//  Created by Andrey Solera on 9/7/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherAPIDelegate {
    func didUpdateWeather(_ data: WeatherData)
    
    func didFailWithError(_ error: Error)
}
