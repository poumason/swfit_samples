//
//  DataScannerRepresentable.swift
//  vision_kit_app
//
//  Created by POU LIN on 2024/1/23.
//

import Foundation
import SwiftUI
import VisionKit

struct DataScannerRepresentable: UIViewControllerRepresentable {
    @Binding var shouldStartScanning: Bool
        @Binding var scannedText: String
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let dataScanner = DataScannerViewController(
            recognizedDataTypes: [
                .text(languages: ["en-US",
                                  "ja_JP",
                                  "zh-TW"]),
                .barcode(symbologies: [
                    .qr, .code93
                ])
            ],
            qualityLevel: .accurate,
            recognizesMultipleItems: true,
            isHighFrameRateTrackingEnabled: true,
            isPinchToZoomEnabled: true,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true)
        dataScanner.delegate = context.coordinator
        return dataScanner
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        if shouldStartScanning {
            try? uiViewController.startScanning()
        } else {
            uiViewController.stopScanning()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: DataScannerRepresentable
        
        init(parent: DataScannerRepresentable) {
            self.parent = parent
        }
        
//        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
//            <#code#>
//        }
//        
//        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
//            
//        }
//        
//        func dataScanner(_ dataScanner: DataScannerViewController, didUpdate updatedItems: [RecognizedItem], allItems: [RecognizedItem]) {
//            <#code#>
//        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            switch item {
            case .text(let text):
                parent.scannedText = text.transcript
            case .barcode(let barcode):
                parent.scannedText = barcode.payloadStringValue ?? "Unable to decode the scanned code"
            default:
                print("unexpected item")
            }
        }
    }
}
