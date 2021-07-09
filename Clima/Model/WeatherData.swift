//
//  WeatherData.swift
//  Clima
//
//  Created by Andrey Solera on 9/7/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation


// Implement the Decodable protocol in order to be able to parse from a JSON result
struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    let conditionID: Int
    let temperature: Double
    
    // This computed property shouldn't be here since it depends on the OpenWeather API conditionIDs
    var conditionName: String {
        get {
            switch conditionID {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "clould.drizzle"
            case 500...532:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun max"
            default: return "clould"
            }
        }
    }
}


struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
}
