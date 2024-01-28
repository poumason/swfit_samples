//
//  ContentView.swift
//  realtimeSTT
//
//  Created by POU LIN on 2023/11/7.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    @State private var isTranscript: Bool = false
    @ObservedObject private var speechRecognizer: SpeechRecognizer = SpeechRecognizer()

    var body: some View {
        VStack {
            Text(speechRecognizer.transcript)
//            Model3D(named: "Scene", bundle: realityKitContentBundle)
//                .padding(.bottom, 50)
//
//            Text("Hello, world!")
//
//            Toggle("Show Immersive Space", isOn: $showImmersiveSpace)
//                .toggleStyle(.button)
//                .padding(.top, 50)
            Toggle(isOn: $isTranscript, label: {
                Text(Image(systemName: "mic"))
                    .font(.largeTitle)
                    .padding(20)
            })
            .toggleStyle(.button)
            .onChange(of: isTranscript) { oldValue, newValue in
                if newValue == true {
                    speechRecognizer.startTranscribing()
                } else {
                    SpeechRecognizer().stopTranscribing()
                }
            }
        }
        .padding()
//        .onChange(of: showImmersiveSpace) { _, newValue in
//            Task {
//                if newValue {
//                    switch await openImmersiveSpace(id: "ImmersiveSpace") {
//                    case .opened:
//                        immersiveSpaceIsShown = true
//                    case .error, .userCancelled:
//                        fallthrough
//                    @unknown default:
//                        immersiveSpaceIsShown = false
//                        showImmersiveSpace = false
//                    }
//                } else if immersiveSpaceIsShown {
//                    await dismissImmersiveSpace()
//                    immersiveSpaceIsShown = false
//                }
//            }
//        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
