//
//  SiriShortcutSetupView.swift
//  SOPFinder
//
//  Created by POU LIN on 2023/12/19.
//

import Foundation
import SwiftUI
import IntentsUI

// Represents the Siri Shortcut setup view.
struct SiriShortcutSetupView: UIViewControllerRepresentable {
    
    // MARK: - Variables -
    @Binding var isPresented: Bool
    
    @Binding var intentPhase:String
    
    // Creates the Siri Shortcut setup view controller.
    func makeUIViewController(context: Context) -> INUIAddVoiceShortcutViewController {
//        let intent = FindSOPIntent()
//        intent.suggestedInvocationPhrase = "Find SOP"
        var intent: INIntent
        if intentPhase == "Find SOP" {
            intent = FindSOPIntent()
        } else {
            intent = DisplayADCChartsIntent()
        }
        intent.suggestedInvocationPhrase = intentPhase
        
        
        let shortcut = INShortcut(intent: intent)!
        let vc = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        vc.delegate = context.coordinator
        return vc
    }
    
    // Updates the Siri Shortcut setup view controller if needed.
    func updateUIViewController(_ uiViewController: INUIAddVoiceShortcutViewController, context: Context) {
        // Update the view controller if needed
    }
    
    // Creates a coordinator to handle interactions with the Siri Shortcut setup view.
    func makeCoordinator() -> Coordinator {
        Coordinator(isPresented: $isPresented)
    }
    
    // Coordinator to handle interactions with the Siri Shortcut setup view.
    class Coordinator: NSObject, INUIAddVoiceShortcutViewControllerDelegate {
        @Binding var isPresented: Bool
        
        init(isPresented: Binding<Bool>) {
            _isPresented = isPresented
        }
        
        // Called when adding a voice shortcut is completed.
        func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
            // Handle the completion
            isPresented = false
        }
        
        // Called when adding a voice shortcut is canceled.
        func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
            // Handle cancellation
            isPresented = false
        }
    }
    
}
