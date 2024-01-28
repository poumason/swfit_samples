//
//  mySiriAppShortcut.swift
//  mySiriApp
//
//  Created by POU LIN on 2024/1/18.
//

import Foundation
import AppIntents

struct MyShortcuts: AppShortcutsProvider {
    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: ScreenshotIntent(),
                    phrases: [
                        "screenshot now",
                        "using \(.applicationName) screenshot"
                    ],
                    shortTitle: "Screenshot now",
                    systemImageName: "chart.bar.xaxis.ascending.badge.clock")
    }
}
