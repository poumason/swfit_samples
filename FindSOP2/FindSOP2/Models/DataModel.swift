//
//  DataModel.swift
//  FindSOP2
//
//  Created by POU LIN on 2023/12/27.
//

import Foundation
import SwiftUI
import Observation

@Observable class DataModel: @unchecked Sendable{
    var target: String
    
    let chartTypes: [String] = [
        "APAN01",
        "APAN02"
    ]
    
    let londonWeatherData = [ WeatherData(year: 2021, month: 7, day: 1, temperature: 19.0),
                                      WeatherData(year: 2021, month: 8, day: 1, temperature: 17.0),
                                      WeatherData(year: 2021, month: 9, day: 1, temperature: 17.0),
                                      WeatherData(year: 2021, month: 10, day: 1, temperature: 13.0),
                                      WeatherData(year: 2021, month: 11, day: 1, temperature: 8.0),
                                      WeatherData(year: 2021, month: 12, day: 1, temperature: 8.0),
                                      WeatherData(year: 2022, month: 1, day: 1, temperature: 5.0),
                                      WeatherData(year: 2022, month: 2, day: 1, temperature: 8.0),
                                      WeatherData(year: 2022, month: 3, day: 1, temperature: 9.0),
                                      WeatherData(year: 2022, month: 4, day: 1, temperature: 11.0),
                                      WeatherData(year: 2022, month: 5, day: 1, temperature: 15.0),
                                      WeatherData(year: 2022, month: 6, day: 1, temperature: 18.0)
    ]
    
    let taipeiWeatherData = [ WeatherData(year: 2021, month: 7, day: 1, temperature: 19.0),
                                      WeatherData(year: 2021, month: 8, day: 1, temperature: 17.0),
                                      WeatherData(year: 2021, month: 9, day: 1, temperature: 17.0),
                                      WeatherData(year: 2021, month: 10, day: 1, temperature: 13.0),
                                      WeatherData(year: 2021, month: 11, day: 1, temperature: 8.0),
                                      WeatherData(year: 2021, month: 12, day: 1, temperature: 8.0),
                                      WeatherData(year: 2022, month: 1, day: 1, temperature: 5.0),
                                      WeatherData(year: 2022, month: 2, day: 1, temperature: 8.0),
                                      WeatherData(year: 2022, month: 3, day: 1, temperature: 9.0),
                                      WeatherData(year: 2022, month: 4, day: 1, temperature: 11.0),
                                      WeatherData(year: 2022, month: 5, day: 1, temperature: 15.0),
                                      WeatherData(year: 2022, month: 6, day: 1, temperature: 18.0)
    ]
    
    let hkWeatherData = [ WeatherData(year: 2021, month: 7, day: 1, temperature: 19.0),
                                  WeatherData(year: 2021, month: 8, day: 1, temperature: 17.0),
                                  WeatherData(year: 2021, month: 9, day: 1, temperature: 17.0),
                                  WeatherData(year: 2021, month: 10, day: 1, temperature: 13.0),
                                  WeatherData(year: 2021, month: 11, day: 1, temperature: 8.0),
                                  WeatherData(year: 2021, month: 12, day: 1, temperature: 8.0),
                                  WeatherData(year: 2022, month: 1, day: 1, temperature: 5.0),
                                  WeatherData(year: 2022, month: 2, day: 1, temperature: 8.0),
                                  WeatherData(year: 2022, month: 3, day: 1, temperature: 9.0),
                                  WeatherData(year: 2022, month: 4, day: 1, temperature: 11.0),
                                  WeatherData(year: 2022, month: 5, day: 1, temperature: 15.0),
                                  WeatherData(year: 2022, month: 6, day: 1, temperature: 18.0)
    ]
    
    init() {
        self.target = ""
    }
}
