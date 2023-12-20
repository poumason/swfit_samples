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
    @State private var intentPhase: String = "Find SOP"
    
    private var eqpList = [
        "APAN01",
        "APAN02",
        "APAN03"
    ]
    
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
                    intentPhase = "Find SOP"
                } label: {
                    HStack(spacing: 0) {
                        Text("Add Find SOP shortcut")
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
                Button {
                    isSiriShortcutPresented = true
                    intentPhase = "Display ADC charts"
                } label: {
                    HStack(spacing: 0) {
                        Text("Add ADC shortcut")
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
                //                    .onAppear(){
                //                        INVocabulary.shared().setVocabulary(NSOrderedSet(array: eqpList), of: .carName)
                //                    }
            }
            //                .navigationTitle("Siri Shortcuts")
        }
        .sheet(isPresented: $isSiriShortcutPresented) {
            SiriShortcutSetupView(
                isPresented: $isSiriShortcutPresented,
                intentPhase: $intentPhase)
        }
        .padding()
        .onContinueUserActivity("FindSOPIntent", perform: { userActivity in
            print("got it from app")
            if userActivity.interaction?.intent is FindSOPIntent {
                
                let _intent: FindSOPIntent = userActivity.interaction?.intent as! FindSOPIntent
                result = _intent.target ?? "default value"
            }
        })
        .onContinueUserActivity("DisplayADCChartsIntent", perform: { userActivity in
            print("got it from app")
            if userActivity.interaction?.intent is DisplayADCChartsIntent {
                
                let _intent: DisplayADCChartsIntent = userActivity.interaction?.intent as! DisplayADCChartsIntent
                result = "\(_intent.toolId ?? "not got"), \(_intent.charttype ?? "not got")"
            }

        })
    }
}

#Preview {
    ContentView()
}
