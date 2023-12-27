//
//  MyShortcuts.swift
//  FindSOP2
//
//  Created by POU LIN on 2023/12/27.
//

import Foundation
import AppIntents

struct MyShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: FindSOPIntent(),
                    phrases: [
                        "Find SOP",
                        "Start \(.applicationName)"
                    ],
                    shortTitle: "Find SOP",
                    systemImageName: "shoeprints.fill")
    }
}
