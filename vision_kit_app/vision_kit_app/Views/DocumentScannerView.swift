//
//  DocumentScannerView.swift
//  vision_kit_app
//
//  Created by POU LIN on 2024/1/27.
//

import Foundation
import SwiftUI
import VisionKit

struct DocumentScannerView: View {
    @State var showScanner: Bool = false
    @State var recognizedContent = RecognizedContent()
    @State var isRecognizing = false
    
    var body: some View {
        NavigationView {
            VStack {
                if VNDocumentCameraViewController.isSupported {
                    Button("Scann") {
                        showScanner = true
                    }
                    ZStack {
                        List(recognizedContent.items, id: \.id) { textItem in
                            NavigationLink(destination: TextPreviewView(text: textItem.text)) {
                                Text(String(textItem.text.prefix(50)).appending("..."))
                            }
                        }
                        if isRecognizing {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color(UIColor.systemIndigo)))
                                .padding(.bottom, 20)
                        }
                    }
                } else {
                    Image(systemName: "multiply.circle")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("It looks like this device doesn't support the VNDocumentCameraViewController")
                }
            }.sheet(isPresented: $showScanner) {
                DocumentScannerRepresentable { result in
                    switch result {
                    case .success(let scannedImages):
                        print("handle image ........")
                        isRecognizing = true
                        TextRecognition(scannedImages: scannedImages,
                                        recognizedContent: recognizedContent) {
                            
                            // Text recognition is finished, hide the progress indicator.
                            isRecognizing = false
                        } .recognizeText()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    
                    showScanner = false
                } didCancelScanning: {
                    showScanner = false
                }
            }
        }
    }
}
