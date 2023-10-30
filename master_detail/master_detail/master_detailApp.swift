//
//  master_detailApp.swift
//  master_detail
//
//  Created by POU LIN on 2023/10/18.
//

import SwiftUI

@main
struct master_detailApp: App {
    @State private var viewStack: MenuItemViewStack = MenuItemViewStack()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            // https://www.appcoda.com.tw/navigationsplitview-swiftui/
            TwoColumnSplitView()
                .environment(viewStack)
//            SplitViewWithStack()
        }
    }
}
