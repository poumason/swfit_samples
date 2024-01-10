//
//  ContentView.swift
//  wakeupApp
//
//  Created by POU LIN on 2024/1/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            MyWebView(url: URL(string: "http://127.0.0.1:5000")!)
                .ignoresSafeArea()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
