//
//  ContentView.swift
//  mySiriApp
//
//  Created by POU LIN on 2024/1/18.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button("open window") {
                openWindow(id: "second-view")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
