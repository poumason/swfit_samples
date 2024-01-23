//
//  ContentView.swift
//  vision_kit_app
//
//  Created by POU LIN on 2024/1/22.
//

import SwiftUI
import VisionKit

struct ContentView: View {
    @State var isShowingScanner = true
    @State private var scannedText = ""
    
    var body: some View {
        VStack {
            if DataScannerViewController.isAvailable && DataScannerViewController.isSupported {
                ZStack {
                    DataScannerRepresentable(shouldStartScanning: $isShowingScanner, scannedText: $scannedText)
                    Text(scannedText)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.white)
                }
            } else {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                if !DataScannerViewController.isSupported {
                    Text("It looks like this device doesn't support the DataScannerViewController")
                } else {
                    Text("It appears your camera may not be available")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
