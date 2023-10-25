//
//  ContentView.swift
//  master_detail
//
//  Created by POU LIN on 2023/10/18.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    var body: some View {
        
        NavigationSplitView {
          // Menu bar
            List{
                Text("A List Item")
                Text("A Second List Item")
                Text("A Third List Item")
            }
        } detail: {
          // Detail view for each of the menu item
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
