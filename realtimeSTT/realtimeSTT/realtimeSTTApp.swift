//
//  realtimeSTTApp.swift
//  realtimeSTT
//
//  Created by POU LIN on 2023/11/7.
//

import SwiftUI

@main
struct realtimeSTTApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
