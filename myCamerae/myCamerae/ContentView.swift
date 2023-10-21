//
//  ContentView.swift
//  myCamerae
//
//  Created by POU LIN on 2023/10/19.
//

import SwiftUI

struct ContentView: View {
    @State var isRunning = false
    let _camera = Camera()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button("click me") {
                isRunning = !isRunning
                if isRunning {
                    _camera.open()
                } else {
                    _camera.close()
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
