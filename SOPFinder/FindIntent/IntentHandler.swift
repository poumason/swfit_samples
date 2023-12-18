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
        if intent is FindSOPIntent {
            return FindSOPHandler()
        }
        else {
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
