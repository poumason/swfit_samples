//
//  ContentView.swift
//  FindSOP2
//
//  Created by POU LIN on 2023/12/25.
//

import SwiftUI
import AppIntents
import Intents
import Charts

struct ContentView: View {
    @Environment(DataModel.self) private var dataModel
    @State var result: String = ""
    
    var body: some View {
        @Bindable var _dataModel = dataModel
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(_dataModel.target.isEmpty  ? "Hello World!":"from Siri result")
                .font(.title2)
                .padding(.vertical, 30)
            Text(_dataModel.target)
                .font(.title)
            Chart {
                BarMark(
                    x: .value("Day", "Monday"),
                    y: .value("Steps", 6019)
                )
                BarMark(
                    x: .value("Day", "Tuesday"),
                    y: .value("Steps", 7200)
                ) }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
