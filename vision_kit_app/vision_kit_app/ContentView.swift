//
//  ContentView.swift
//  vision_kit_app
//
//  Created by POU LIN on 2024/1/22.
//

import SwiftUI
import VisionKit

struct ContentView: View {
    var body: some View {
        VStack {
            TabView {
                DataScannerView()
                    .tabItem {
                        Label("Data Scanner", systemImage: "qrcode.viewfinder")
                    }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
