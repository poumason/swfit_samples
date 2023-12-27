//
//  FindSOP.swift
//  SOPFinder
//
//  Created by POU LIN on 2023/12/25.
//

import Foundation
import AppIntents

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct FindSOP: AppIntent, CustomIntentMigratedAppIntent, PredictableIntent {
    static let intentClassName = "FindSOPIntent"

    static var title: LocalizedStringResource = "Find SOP"
    static var description = IntentDescription("")

    @Parameter(title: "Target")
    var target: String?

    static var parameterSummary: some ParameterSummary {
        Summary("find SOP about \(\.$target)")
    }

    static var predictionConfiguration: some IntentPredictionConfiguration {
        IntentPrediction(parameters: (\.$target)) { target in
            DisplayRepresentation(
                title: "find SOP about \(target!)",
                subtitle: ""
            )
        }
    }

    func perform() async throws -> some IntentResult {
        // TODO: Place your refactored intent handler code here.
        return .result()
    }
}

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
fileprivate extension IntentDialog {
    static var targetParameterPrompt: Self {
        "Which kind of SOP do you want?"
    }
    static func responseSuccess(result: String) -> Self {
        "finded it, \(result)"
    }
    static var responseFailure: Self {
        "Oops! Looks like something went wrong! "
    }
}

