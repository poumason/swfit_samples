//
//  IntentHandler.swift
//  FindIntent
//
//  Created by POU LIN on 2023/12/18.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        switch intent {
        case is FindSOPIntent:
            return FindSOPHandler()
        case is DisplayADCChartsIntent:
            return DisplayADCChartHandler()
        default:
            fatalError("Unhandled Intent error : \(intent)")
        }
    }
    
}

class FindSOPHandler: NSObject, FindSOPIntentHandling {
    
    func handle(intent: FindSOPIntent) async -> FindSOPIntentResponse {
        if intent.target != nil {
            //            return FindSOPIntentResponse.success(result: intent.target!)
            return FindSOPIntentResponse(code: .continueInApp, userActivity: nil)
        }
        else {
            return FindSOPIntentResponse(code: .failure, userActivity: nil)
        }
    }
    
    
    func resolveTarget(for intent: FindSOPIntent) async -> INStringResolutionResult {
        guard let target = intent.target else {
            return INStringResolutionResult.needsValue()
        }
        print("got target, \(target)")
        return INStringResolutionResult.success(with: target)
    }
}


class DisplayADCChartHandler: NSObject, DisplayADCChartsIntentHandling {
    
    func handle(intent: DisplayADCChartsIntent) async -> DisplayADCChartsIntentResponse {
        if intent.toolId != nil && intent.charttype != nil {
            //            return FindSOPIntentResponse.success(result: intent.target!)
            return DisplayADCChartsIntentResponse(code: .continueInApp, userActivity: nil)
        }
        else {
            return DisplayADCChartsIntentResponse(code: .failure, userActivity: nil)
        }
    }
    
    func resolveToolId(for intent: DisplayADCChartsIntent) async -> INStringResolutionResult {
        guard let toolId = intent.toolId else {
            return INStringResolutionResult.needsValue()
        }
        print("got tool id, \(toolId)")
        return INStringResolutionResult.success(with: toolId)
    }
    
    func resolveCharttype(for intent: DisplayADCChartsIntent) async -> INStringResolutionResult {
        guard let chartType = intent.charttype else {
            return INStringResolutionResult.needsValue()
        }
        print("got chart type, \(chartType)")
        return INStringResolutionResult.success(with: chartType)
    }
}
