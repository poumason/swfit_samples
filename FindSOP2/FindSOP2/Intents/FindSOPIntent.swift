//
//  FindSOPIntent.swift
//  FindSOP2
//
//  Created by POU LIN on 2023/12/25.
//

import Foundation
import AppIntents
import SwiftUI

struct FindSOPIntent: AppIntent {
    
    static let title: LocalizedStringResource = "Find SOP"
    
    static let openAppWhenRun: Bool = true
    
    @Parameter(title: "Target", requestValueDialog: IntentDialog("Which kind of SOP do you want?"))
    var target: String
    
    init() {
        
    }
    init(target: String) {
        self.target = target
    }
    
    static var parameterSummary: some ParameterSummary {
        Summary("find SOP about \(\.$target)")
    }
    
    @Dependency
    private var dataModel: DataModel
    
//    static var predictionConfiguration: some IntentPredictionConfiguration {
//        IntentPrediction(parameters: (\.$target)) { target in
//            DisplayRepresentation(
//                title: "find SOP about \(target!)",
//                subtitle: ""
//            )
//        }
//    }
    
    func perform() async throws -> some IntentResult {
//    & ReturnsValue<String> & OpensIntent{
//        return .result(
//            value: target,
//            opensIntent: FindSOPIntent(target: self.target))
        dataModel.target = target
        return .result()
    }
}
