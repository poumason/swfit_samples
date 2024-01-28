//
//  _d_demo_appApp.swift
//  3d_demo_app
//
//  Created by POU LIN on 2024/1/28.
//

import SwiftUI

@main
struct _d_demo_appApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
