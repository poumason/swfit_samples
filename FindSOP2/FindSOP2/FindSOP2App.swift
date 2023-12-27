//
//  FindSOP2App.swift
//  FindSOP2
//
//  Created by POU LIN on 2023/12/25.
//

import SwiftUI
import AppIntents


@main
struct FindSOP2App: App {
    private var dataModel: DataModel
    
    init() {
        let _dataModel = DataModel()
        self.dataModel = _dataModel
        
        AppDependencyManager.shared.add(dependency: _dataModel)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataModel)
        }
    }
}
