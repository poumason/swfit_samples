//
//  SearchToolHandler.swift
//  MessageIntent
//
//  Created by POU LIN on 2023/12/18.
//

import Foundation
import Intents

class SearchToolHandler: NSObject, SearchToolIntentHandling {
    func resolveToolName(for intent: SearchToolIntent) async -> SearchToolToolNameResolutionResult {
        if let tool = intent.toolName, !tool.isEmpty {
            print(tool)
            return SearchToolToolNameResolutionResult.success(with: tool)
        } else {
            return SearchToolToolNameResolutionResult.needsValue()
        }
    }
    
//    func handle(intent: SearchToolIntent, completion: @escaping (SearchToolIntentResponse) -> Void) {
//        <#code#>
//    }
//    
    func handle(intent: SearchToolIntent) async -> SearchToolIntentResponse {
//        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSendMessageIntent.self))
//        let response = INSendMessageIntentResponse(code: .success, userActivity: userActivity)
//        completion(response)
        let response = SearchToolIntentResponse(code: .success, userActivity: nil)
        return response
    }
    
//    func resolveToolName(for intent: SearchToolIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
//        if let tool = intent.toolName, !tool.isEmpty {
//            print(tool)
//            completion(INStringResolutionResult.success(with: tool))
//        } else {
//            completion(INStringResolutionResult.needsValue())
//        }
//    }
//    func resolveContent(for intent: INSendMessageIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
//        if let text = intent.content, !text.isEmpty {
//            print(text)
//            completion(INStringResolutionResult.success(with: text))
//        } else {
//            completion(INStringResolutionResult.needsValue())
//        }
//    }
//    
    func resolveToolName(for intent: SearchToolIntent) async -> INStringResolutionResult {
        if let tool = intent.toolName, !tool.isEmpty {
            print(tool)
            return INStringResolutionResult.success(with: tool)
        } else {
            return INStringResolutionResult.needsValue()
        }
    }
    
    
}
