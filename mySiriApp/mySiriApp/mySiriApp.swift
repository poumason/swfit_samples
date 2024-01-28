//
//  mySiriAppApp.swift
//  mySiriApp
//
//  Created by POU LIN on 2024/1/18.
//

import SwiftUI

@main
struct mySiriApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        WindowGroup(id: "second-view") {
            SecondView()
        }
    }
}
