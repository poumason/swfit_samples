//
//  ChartEntity.swift
//  FindSOP2
//
//  Created by POU LIN on 2023/12/27.
//

import Foundation
import AppIntents

struct WeatherData: Identifiable {
    let id = UUID()
    let date: Date
    let temperature: Double

    init(year: Int, month: Int, day: Int, temperature: Double) {
        self.date = Calendar.current.date(from: .init(year: year, month: month, day: day)) ?? Date()
        self.temperature = temperature
    }
}
