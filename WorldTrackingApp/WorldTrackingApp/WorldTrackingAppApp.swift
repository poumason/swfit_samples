//
//  WorldTrackingAppApp.swift
//  WorldTrackingApp
//
//  Created by POU LIN on 2024/1/28.
//

import SwiftUI

@main
struct WorldTrackingAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
