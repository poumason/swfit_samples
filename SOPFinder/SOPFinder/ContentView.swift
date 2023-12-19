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
    @State private var isSiriShortcutPresented = false
    
    var body: some View {
        NavigationView{
            
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                Text(result.isEmpty ? "Hello World!":"from Siri result")
                    .font(.title2)
                    .padding(.vertical, 30)
                Text(result)
                    .font(.title)
                Spacer()
                Button {
                    isSiriShortcutPresented = true
                } label: {
                    HStack(spacing: 0) {
                        Image("siriIcon")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("Add to Siri")
                            .font(.title2)
                            .padding()
                            .foregroundColor(.white)
                    }
                    .padding(.all, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.black)
                    )
                }
                Spacer()
            }
            //                .navigationTitle("Siri Shortcuts")
        }
        .sheet(isPresented: $isSiriShortcutPresented) {
            SiriShortcutSetupView(isPresented: $isSiriShortcutPresented)
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
