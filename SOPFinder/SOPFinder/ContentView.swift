//
//  ContentView.swift
//  SOPFinder
//
//  Created by POU LIN on 2023/12/18.
//

import SwiftUI
import Intents

struct ContentView: View {
    @State var result: String = ""
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text(result)
        }
        .padding()
        .onContinueUserActivity("FindSOPIntent", perform: { userActivity in
            print("got it from app")
            if userActivity.interaction?.intent is FindSOPIntent {
                
                let _intent: FindSOPIntent = userActivity.interaction?.intent as! FindSOPIntent
                result = _intent.target ?? "default value"
            }
        })
    }
}

#Preview {
    ContentView()
}
