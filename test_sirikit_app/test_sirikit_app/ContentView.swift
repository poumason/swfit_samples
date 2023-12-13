//
//  ContentView.swift
//  test_sirikit_app
//
//  Created by POU LIN on 2023/12/13.
//

import SwiftUI
import Intents

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear() {
            INPreferences.requestSiriAuthorization { status in
                if status == .authorized {
                    print("got authorized")
                } else {
                    print("not authorized")
                }
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
