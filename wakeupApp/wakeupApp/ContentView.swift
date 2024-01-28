//
//  ContentView.swift
//  wakeupApp
//
//  Created by POU LIN on 2024/1/10.
//

import SwiftUI

struct ContentView: View {
    var navigationState: NavigationState = NavigationState()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            //            MyWebView(url: URL(string: "http://127.0.0.1:5000")!)
            //                .ignoresSafeArea()
            ZStack {
                WebViewUI(navigationState: navigationState)
                if navigationState.isLoading {
                    ProgressView()
                }
            }
            HStack {
                Button("Back") {
                    navigationState.webView.goBack()
                }
                Button("Forward") {
                    navigationState.webView.goForward()
                }
                Button("JS") {
                    navigationState.invokeJS()
                }
            }
            
        }
        .padding()
        .onAppear {
            navigationState.loadRequest(URLRequest(url: URL(string: "http://127.0.0.1:5000")!))
        }
    }
}

#Preview {
    ContentView()
}
