//
//  DisplayChartIntents.swift
//  FindSOP2
//
//  Created by POU LIN on 2023/12/27.
//

import Foundation
import AppIntents

struct DisplayChartIntent: AppIntent {
    static var title: LocalizedStringResource = "Display Chart"
    
//    @Parameter(title: "Chart Type", requestValueDialog: "Which chart?", optionsProvider: ChartTypeOptionsProvider())
//    var chartType: String
    
    @Parameter(title: "Chart Type", requestValueDialog: "Which category?")
    var chartType: ChartEntity
    
//    @Dependency
//    private var dataModel: DataModel
    
    func perform() async throws -> some IntentResult & ProvidesDialog & ShowsSnippetView {
       
//        if DataManager.shared.chartTypes.contains(chartType) == false {
//            throw $chartType.needsValueError("please choice again")
//        }
        if chartType.name.isEmpty  {
            throw $chartType.needsValueError("please choice again")
        }
        
        return .result(dialog: "you choice \(chartType.name)") {
            ChartView()
        }
    }
}


struct ChartTypeOptionsProvider: DynamicOptionsProvider {
    @Dependency
    private var dataModel: DataModel
    
    func results() async throws -> [String] {
//        return ["APAN01", "APAN02", "APAN03"]
        return DataManager.shared.chartTypes
    }
}
