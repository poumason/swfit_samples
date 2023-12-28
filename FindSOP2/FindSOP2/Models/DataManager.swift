//
//  DataManager.swift
//  FindSOP2
//
//  Created by POU LIN on 2023/12/28.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    let chartTypes: [String] = [
        "APAN01",
        "APAN02"
    ]
    
    let chartCategory: [ChartEntity] = [
        ChartEntity(id: UUID(), name: "Category one", description: ""),
        ChartEntity(id: UUID(), name: "Category two", description: ""),
        ChartEntity(id: UUID(), name: "Category three", description: "")
    ]
}
